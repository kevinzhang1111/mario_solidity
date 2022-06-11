// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.7.0;

import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/EnumerableSet.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";


contract Mod is ERC20Burnable, Ownable {
    using SafeMath for uint256;
    using EnumerableSet for EnumerableSet.AddressSet;

    EnumerableSet.AddressSet private _minters;


    constructor(uint256 initialSupply) public ERC20("Mario Coin", "Mod") {
        _mint(msg.sender, initialSupply);
    }

    function mint(address _to, uint256 _amount)
    public
    onlyMinter
    returns (bool)
    {
        _mint(_to, _amount);
        return true;
    }

    function addMinter(address _addMinter) public onlyOwner returns (bool) {
        require(_addMinter != address(0), "addMinter invalid");
        return EnumerableSet.add(_minters, _addMinter);
    }

    function delMinter(address _delMinter) public onlyOwner returns (bool) {
        require(_delMinter != address(0), "delMinter invalid");
        return EnumerableSet.remove(_minters, _delMinter);
    }

    function _isMinter(address account) internal view returns (bool) {
        return EnumerableSet.contains(_minters, account);
    }

    modifier onlyMinter() {
        require(_isMinter(msg.sender), "not minter");
        _;
    }
}
