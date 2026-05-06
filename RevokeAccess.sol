// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RevokeAccess {

    struct Patient {
        bool isRegistered;
    }

    // pasien
    mapping(address => Patient) public patients;

    // access control
    mapping(address => mapping(address => bool)) public accessControl;

    // event
    event AccessRevoked(address patient, address doctor, uint timestamp);

    // PSEUDOCODE
    /*
    FUNCTION revokeAccess(_doctor):
      REQUIRE caller (msg.sender) is registered patient
      REQUIRE accessControl[msg.sender][_doctor] == true
      SET accessControl[msg.sender][_doctor] = false
      EMIT AccessRevoked(msg.sender, _doctor, block.timestamp)
    */

    function revokeAccess(address _doctor) public {

        require(
            patients[msg.sender].isRegistered == true,
            "Not registered patient"
        );

        require(
            accessControl[msg.sender][_doctor] == true,
            "Access not found"
        );

        accessControl[msg.sender][_doctor] = false;

        emit AccessRevoked(msg.sender, _doctor, block.timestamp);
    }
}
