// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

import {Base64} from "./libraries/Base64.sol";



contract NFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string uri = "";

    string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    string[] firstWords = ["big", "dana", "poe", "gates", "buffet", "munger","oppenheimer","noice","bob","orville","estee","winston","space","mars"];
    string[] secondWords = ["tuna", "harvey", "singleton", "musk", "gates", "arnold","groves","elon","thomas","bryant","michael","chruchill","henry","rocket"];
    string[] thirdWords = ["moon", "boy", "edwin", "wright", "jobs", "serra","lucas","edison","alexander","kobe","jordan","plane","transistor","ford"];

    constructor() ERC721("BOOKs","BKY"){
        console.log("NFTeez");
    }

    function makeNFT() public  {
    uint256 newNFTID = _tokenIds.current();

    string memory first = pickRandomFirstWord(newNFTID);
    string memory second = pickRandomSecondWord(newNFTID);
    string memory third = pickRandomThirdWord(newNFTID);
    string memory combinedWord = string(abi.encodePacked(first, second, third));
    string memory finalSvg = string(abi.encodePacked(baseSvg, combinedWord, "</text></svg>"));

    console.log("\n--------------------");
    console.log(finalSvg);
    console.log("--------------------\n");

    string memory json = Base64.encode(
        bytes(
            string(
                abi.encodePacked(
                    '{"name": "',
                    combinedWord,
                    '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
                    Base64.encode(bytes(finalSvg)),
                    '"}'
                )
            )
        )
    );

        string memory finalTokenUri = string(
        abi.encodePacked("data:application/json;base64,", json)
    );

    console.log("\n--------------------");
    console.log(finalTokenUri);
    console.log("--------------------\n");

    uri = finalTokenUri;

        _safeMint(msg.sender,newNFTID);

        tokenURI(newNFTID);

        _tokenIds.increment();
    }

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        require(_exists(_tokenId),"what");
        console.log("An NFT w/ ID %s has been minted to %s", _tokenId, msg.sender);
        return (uri);
    }

  function pickRandomFirstWord(uint256 tokenId) public view returns (string memory) {
    // I seed the random generator. More on this in the lesson. 
    uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
    // Squash the # between 0 and the length of the array to avoid going out of bounds.
    rand = rand % firstWords.length;
    return firstWords[rand];
  }

  function pickRandomSecondWord(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));
    rand = rand % secondWords.length;
    return secondWords[rand];
  }

  function pickRandomThirdWord(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId))));
    rand = rand % thirdWords.length;
    return thirdWords[rand];
  }

  function random(string memory input) internal pure returns (uint256) {
      return uint256(keccak256(abi.encodePacked(input)));
  }

}



