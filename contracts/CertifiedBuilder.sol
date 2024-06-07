// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

// import {ERC1155Supply} from "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
// import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

contract CertifiedBuilder is ERC1155 {
    address public owner;

    modifier onlyOwner() {
        require(owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    constructor()
        ERC1155("ipfs://QmR6uDnHca3kWPczm4LeH3putoc5BgryLERFjws1djKY4p.json")
    {
        owner = msg.sender;
    }

    function mint(uint256 recipientsNumber) public onlyOwner {
        _mint(msg.sender, 0, recipientsNumber, "");
    }

    function airdrop(address[] calldata recipients) external onlyOwner {
        for (uint i = 0; i < recipients.length; i++) {
            _safeTransferFrom(msg.sender, recipients[i], 0, 1, "");
        }
    }

    // _update override required by Solidity
    // function _update(
    //     address from,
    //     address to,
    //     uint256[] memory ids,
    //     uint256[] memory values
    // ) internal override(ERC1155, ERC1155Supply) {
    //     super._update(from, to, ids, values);
    // }

    function contractURI() public pure returns (string memory) {
        return "ipfs://QmR6uDnHca3kWPczm4LeH3putoc5BgryLERFjws1djKY4p.json";
    }

    function uri(
        uint256 _tokenid
    ) public pure override returns (string memory) {
        return "ipfs://QmR5ei3jFk68mivLDEj28YJNSt4E6M2p3Fswk996pX8eMc.png";
    }
}
