// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract CertifiedBuilder is ERC1155 {
    address public contractOwner;

    modifier onlyOwner() {
        require(
            contractOwner == msg.sender,
            "Only the contractOwner can call this function."
        );
        _;
    }

    constructor()
        ERC1155(
            "https://scarlet-reasonable-mule-649.mypinata.cloud/ipfs/QmQ4vTLRwyQU9ujyVD1PfoCPpzzET4TaS76aPdQ2Pkwfnh"
        )
    {
        contractOwner = msg.sender;
    }

    function mint(uint256 recipientsNumber) public onlyOwner {
        _mint(msg.sender, 0, recipientsNumber, "");
    }

    function airdrop(address[] calldata recipients) external onlyOwner {
        for (uint i = 0; i < recipients.length; i++) {
            _safeTransferFrom(msg.sender, recipients[i], 0, 1, "");
        }
    }

    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal view override {
        require(
            from == address(0) || from == contractOwner,
            "This is a soulbound token / non-transferable badge"
        );
    }

    function contractURI() public pure returns (string memory) {
        return
            "https://scarlet-reasonable-mule-649.mypinata.cloud/ipfs/QmQ4vTLRwyQU9ujyVD1PfoCPpzzET4TaS76aPdQ2Pkwfnh";
    }

    function uri(
        uint256 _tokenid
    ) public pure override returns (string memory) {
        return
            "https://scarlet-reasonable-mule-649.mypinata.cloud/ipfs/QmQ4vTLRwyQU9ujyVD1PfoCPpzzET4TaS76aPdQ2Pkwfnh";
    }
}
