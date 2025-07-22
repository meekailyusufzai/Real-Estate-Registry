// SPDX-License-Identifier:
pragma solidity ^0.8.19;

contract RealEstateRegistry {
    struct Property {
        uint256 id;
        string location;
        uint256 area; // in square feet
        uint256 price; // in wei
        address owner;
        bool isForSale;
        bool exists;
        uint256 registrationDate;
    }

    mapping(uint256 => Property) public properties;
    mapping(address => uint256[]) public ownerProperties;
    
    uint256 public nextPropertyId = 1;
    address public registrar;
    
    event PropertyRegistered(
        uint256 indexed propertyId,
        address indexed owner,
        string location,
        uint256 area,
        uint256 price
    );
    
    event PropertyTransferred(
        uint256 indexed propertyId,
        address indexed from,
        address indexed to,
        uint256 price
    );
    
    event PropertyStatusChanged(
        uint256 indexed propertyId,
        bool isForSale,
        uint256 newPrice
    );

    modifier onlyRegistrar() {
        require(msg.sender == registrar, "Only registrar can perform this action");
        _;
    }

    modifier onlyPropertyOwner(uint256 _propertyId) {
        require(
            properties[_propertyId].owner == msg.sender,
            "Only property owner can perform this action"
        );
        _;
    }

    modifier propertyExists(uint256 _propertyId) {
        require(properties[_propertyId].exists, "Property does not exist");
        _;
    }

    constructor() {
        registrar = msg.sender;
    }

    /**
     * @dev Register a new property in the registry
     * @param _location Property location/address
     * @param _area Property area in square feet
     * @param _price Property price in wei
     * @param _owner Property owner address
     */
    function registerProperty(
        string memory _location,
        uint256 _area,
        uint256 _price,
        address _owner
    ) external onlyRegistrar returns (uint256) {
        require(_owner != address(0), "Invalid owner address");
        require(_area > 0, "Area must be greater than 0");
        require(bytes(_location).length > 0, "Location cannot be empty");

        uint256 propertyId = nextPropertyId;
        
        properties[propertyId] = Property({
            id: propertyId,
            location: _location,
            area: _area,
            price: _price,
            owner: _owner,
            isForSale: false,
            exists: true,
            registrationDate: block.timestamp
        });

        ownerProperties[_owner].push(propertyId);
        nextPropertyId++;

        emit PropertyRegistered(propertyId, _owner, _location, _area, _price);
        
        return propertyId;
    }

    /**
     * @dev Transfer property ownership from one address to another
     * @param _propertyId Property ID to transfer
     * @param _newOwner New owner address
     */
    function transferProperty(
        uint256 _propertyId,
        address _newOwner
    ) external payable propertyExists(_propertyId) {
        Property storage property = properties[_propertyId];
        
        require(_newOwner != address(0), "Invalid new owner address");
        require(property.isForSale, "Property is not for sale");
        require(msg.value >= property.price, "Insufficient payment");
        require(msg.sender != property.owner, "Cannot transfer to yourself");

        address previousOwner = property.owner;
        
        // Remove property from previous owner's list
        _removePropertyFromOwner(previousOwner, _propertyId);
        
        // Add property to new owner's list
        ownerProperties[_newOwner].push(_propertyId);
        
        // Update property ownership
        property.owner = _newOwner;
        property.isForSale = false;
        
        // Transfer payment to previous owner
        payable(previousOwner).transfer(property.price);
        
        // Refund excess payment
        if (msg.value > property.price) {
            payable(msg.sender).transfer(msg.value - property.price);
        }

        emit PropertyTransferred(_propertyId, previousOwner, _newOwner, property.price);
    }

    /**
     * @dev Update property sale status and price
     * @param _propertyId Property ID to update
     * @param _isForSale Whether property is for sale
     * @param _newPrice New price (only relevant if for sale)
     */
    function updatePropertyStatus(
        uint256 _propertyId,
        bool _isForSale,
        uint256 _newPrice
    ) external onlyPropertyOwner(_propertyId) propertyExists(_propertyId) {
        Property storage property = properties[_propertyId];
        
        if (_isForSale) {
            require(_newPrice > 0, "Price must be greater than 0");
            property.price = _newPrice;
        }
        
        property.isForSale = _isForSale;

        emit PropertyStatusChanged(_propertyId, _isForSale, _newPrice);
    }

    /**
     * @dev Get property details
     * @param _propertyId Property ID
     */
    function getProperty(uint256 _propertyId) 
        external 
        view 
        propertyExists(_propertyId) 
        returns (
            uint256 id,
            string memory location,
            uint256 area,
            uint256 price,
            address owner,
            bool isForSale,
            uint256 registrationDate
        ) 
    {
        Property memory property = properties[_propertyId];
        return (
            property.id,
            property.location,
            property.area,
            property.price,
            property.owner,
            property.isForSale,
            property.registrationDate
        );
    }

    /**
     * @dev Get all properties owned by an address
     * @param _owner Owner address
     */
    function getPropertiesByOwner(address _owner) 
        external 
        view 
        returns (uint256[] memory) 
    {
        return ownerProperties[_owner];
    }

    /**
     * @dev Get total number of registered properties
     */
    function getTotalProperties() external view returns (uint256) {
        return nextPropertyId - 1;
    }

    /**
     * @dev Internal function to remove property from owner's list
     */
    function _removePropertyFromOwner(address _owner, uint256 _propertyId) internal {
        uint256[] storage ownerPropertyList = ownerProperties[_owner];
        for (uint256 i = 0; i < ownerPropertyList.length; i++) {
            if (ownerPropertyList[i] == _propertyId) {
                ownerPropertyList[i] = ownerPropertyList[ownerPropertyList.length - 1];
                ownerPropertyList.pop();
                break;
            }
        }
    }

    /**
     * @dev Emergency function to change registrar (only current registrar)
     */
    function changeRegistrar(address _newRegistrar) external onlyRegistrar {
        require(_newRegistrar != address(0), "Invalid registrar address");
        registrar = _newRegistrar;
    }
}
