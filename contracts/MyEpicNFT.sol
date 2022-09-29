// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "hardhat/console.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string baseSvg =
        "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    string[] firstWords = ["I'm", "My", "She", "He", "They", "There"];
    string[] secondWords = [
        "serious",
        "stupid",
        "terrible",
        "super",
        "honest",
        "ambitious"
    ];
    string[] thirdWords = ["boy", "girl", "man", "ledy", "people", "thing"];

    constructor() ERC721("SquareNFT", "SQUARE") {
        console.log("This is my NFT contract.");
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function pickRandomFirstWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId)))
        );
        console.log("rand seed: ", rand);
        rand = rand % firstWords.length;
        console.log("rand first word: ", rand);
        return firstWords[rand];
    }

    // pickRandomSecondWord関数は、2番目に表示されるの単語を選びます。
    function pickRandomSecondWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        // pickRandomSecondWord 関数のシードとなる rand を作成します。
        uint256 rand = random(
            string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId)))
        );
        rand = rand % secondWords.length;
        return secondWords[rand];
    }

    // pickRandomThirdWord関数は、3番目に表示されるの単語を選びます。
    function pickRandomThirdWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        // pickRandomThirdWord 関数のシードとなる rand を作成します。
        uint256 rand = random(
            string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId)))
        );
        rand = rand % thirdWords.length;
        return thirdWords[rand];
    }

    function makeAnEpicNFT() public {
        uint256 newItemId = _tokenIds.current();

        // 3つの配列からそれぞれ1つの単語をランダムに取り出します。
        string memory first = pickRandomFirstWord(newItemId);
        string memory second = pickRandomSecondWord(newItemId);
        string memory third = pickRandomThirdWord(newItemId);

        // 3つの単語を連結して、<text>タグと<svg>タグで閉じます。
        string memory finalSvg = string(
            abi.encodePacked(baseSvg, first, second, third, "</text></svg>")
        );

        // NFTに出力されるテキストをターミナルに出力します。
        console.log("\n--------------------");
        console.log(finalSvg);
        console.log("--------------------\n");

        _safeMint(msg.sender, newItemId);

        // tokenURI は後で設定します。
        // 今は、tokenURI の代わりに、"We will set tokenURI later." を設定します。
        _setTokenURI(newItemId, "We will set tokenURI later.");
        console.log(
            "An NFT w/ ID %S has been minted to %S",
            newItemId,
            msg.sender
        );
        _tokenIds.increment();
    }
}
