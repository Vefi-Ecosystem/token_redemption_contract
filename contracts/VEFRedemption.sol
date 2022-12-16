pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./helpers/TransferHelpers.sol";

contract VEFRedemption is Ownable {
    address public constant vefiV1 = 0xD6447d2fA919811c41a064bDbdaB1E281F8de9B2;
    address public constant vefiV2 = 0xA0beD207C2449e84dc56128B22FdB077C1930495;
    address public constant vefiCurrent = 0x34308d0ECF3aA69c94722d860649a54F641573C1;

    mapping(address => bool) public redeemed;

    function redeem() external {
        require(!redeemed[_msgSender()], "already_redeemed");
        uint256 _amount = IERC20(vefiV1).balanceOf(_msgSender());

        if (IERC20(vefiV2).balanceOf(_msgSender()) > _amount) {
            _amount = IERC20(vefiV2).balanceOf(_msgSender());
        }

        TransferHelpers._safeTransferERC20(
            vefiCurrent,
            _msgSender(),
            _amount
        );
        redeemed[_msgSender()] = true;
    }

    function retrieveERC20(
        address token,
        address to,
        uint256 amount
    ) external onlyOwner {
        TransferHelpers._safeTransferERC20(token, to, amount);
    }
}
