// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("TanyaNFT", "TANYA") {
        console.log("This is my NFT contract.");
    }

    function makeAnEpicNFT() public {
        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, "https://api.npoint.io/ba9de3c244219534fab0");
        console.log(
            "An NFT w/ ID %S has been minted to %S",
            newItemId,
            msg.sender
        );
        _tokenIds.increment();
    }
}
