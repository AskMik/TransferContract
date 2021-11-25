//SPDX-Liscence-Identifier : MIT
pragma solidity >0.8.0 ;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";


contract TransferContract{

constructor(){
    Owner = payable(msg.sender);
    SupportInterface[0x36372b07]= true;
}


uint Value;
uint Amount;
address payable Owner;
uint Fees = (Amount/10)  / 100;
uint FeesDeduction = Amount - Fees;
address payable  ContractAddress = payable(address(this));
ERC20 e = ERC20(msg.sender);

mapping(bytes4 => bool) SupportInterface;

function Transfer_Ether(uint amountToBeTransferred, address payable[] memory Ether_Receivers) public payable returns(uint, uint, bool) {
    Amount = amountToBeTransferred;

    require(msg.sender.balance > 0);
    require(msg.value < Amount);
    require(Ether_Receivers.length > 0);
    uint EqualAmount = Amount / Ether_Receivers.length;
    
    ContractAddress.transfer(FeesDeduction);

     for (uint256 i = 0; i < Ether_Receivers.length; i++)
            Ether_Receivers[i].transfer(EqualAmount);

            return(FeesDeduction, EqualAmount, true);
}

function Transfer_ERC20(bytes4 YourTokenInterface, address payable[] memory ERC20_Receivers, uint value) public payable returns(bool){
    require(SupportInterface[YourTokenInterface] = true, "Your Token must be ERC20");
    Value = value;
    uint FeeDeduction = Value - Fees;
    uint EqualValue = Value / ERC20_Receivers.length;

    e.transfer(ContractAddress, FeeDeduction);
    
    for (uint256 i = 0; i < ERC20_Receivers.length; i++)
            e.transferFrom(msg.sender, ERC20_Receivers[i], EqualValue);
            
            return true;

}

function WithdrawEthers(uint AMOUNT) private returns(bool){
    require(msg.sender == Owner);
    Owner.transfer(AMOUNT);
    return true;
}

function WithdrawERC20(uint VALUE) private returns(bool){
    require(msg.sender == Owner);
    e.transfer(Owner, VALUE);
    return true;
}
}