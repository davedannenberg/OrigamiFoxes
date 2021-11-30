//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";
// import "@openzeppelin/contracts/presets/ERC721PresetMinterPauserAutoId.sol";

contract NFTCollectible is ERC721Enumerable, Ownable {
    using SafeMath for uint256;
    using Counters for Counters.Counter;
    
    Counters.Counter private _tokenIds;
    
    uint public constant MAX_SUPPLY = 760; // Maximum number of NFTs that can be minted
    // uint public constant PRICE = 0.0000001 ether; // Free distribution to bootcamp students
    uint public constant MAX_PER_MINT = 1; // Only one NFT per mint
    
    string public baseTokenURI;
    string public completeURI;
    // Constructor to set the name and symbol of NFT collection.
    // event CreateFox(uint256 indexed id);
    constructor(string memory baseURI) ERC721("Origami Foxes", "OF") {
        // completeURI = baseURI + ".png";
        setBaseURI(baseURI);
    }
    
    // function baseTokenURI() public view returns (string memory) {
    // return "ipfs://QmNWF1pqcc49fRhXysj7TNZ6SBg7gVDcQKLjg25JRMcvGX/";
    // }
    // Mint NFTs for free to bootcamp students
    function reserveNFTs() public onlyOwner {
        uint totalMinted = _tokenIds.current();
        uint freeFoxes = 760; // Minting 820 NFTs for free

        require(totalMinted.add(freeFoxes) < MAX_SUPPLY, "Not enough NFTs left to reserve"); 

        for (uint i = 0; i < freeFoxes; i++) {
            _mintSingleNFT();
        }
    }
    
    // Replace _baseURI with base URI we define below
    function _baseURI() internal view virtual override returns (string memory) {
        return baseTokenURI;
    }
    
    // Set base token URI to NFT JSON metadata located in IPFS.
    function setBaseURI(string memory _baseTokenURI) public onlyOwner {
        baseTokenURI = _baseTokenURI;
    }
    

    // Checks before minting NFT from collection
    function mintNFTs(uint _count) public {
        uint totalMinted = _tokenIds.current();

        require(totalMinted.add(_count) <= MAX_SUPPLY, "Not enough NFTs left!");
        require(_count >0 && _count <= MAX_PER_MINT, "Cannot mint specified number of NFTs.");
        //require(msg.value >= PRICE.mul(_count), "Not enough ether to purchase NFTs.");

        for (uint i = 0; i < _count; i++) {
            _mintSingleNFT();
        }
    }

    //Returns URI for collection
    // function tokenURI(uint256 _tokenId) public view override returns (string memory) {
    //     return baseTokenURI;
    // }
    
    // Function to mint NFT from collection
    function _mintSingleNFT() private {
        uint newTokenID = _tokenIds.current();
        _safeMint(msg.sender, newTokenID);
        _tokenIds.increment();
    }
    
    // Get NFT tokens ownn by a particular account
    function tokensOfOwner(address _owner) external view returns (uint[] memory) {

        uint tokenCount = balanceOf(_owner);
        uint[] memory tokensId = new uint256[](tokenCount);

        for (uint i = 0; i < tokenCount; i++) {
            tokensId[i] = tokenOfOwnerByIndex(_owner, i);
        }
        return tokensId;
    }
    
    // No payment required so no withdrawal function needed
    
    //function withdraw() public payable onlyOwner {
    //    uint balance = address(this).balance;
    //    require(balance > 0, "No ether left to withdraw");

    //    (bool success, ) = (msg.sender).call{value: balance}("");
    //    require(success, "Transfer failed.");
    //}
    
}