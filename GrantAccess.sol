// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GrantAccess {

    struct Patient {
        bool isRegistered;
    }

    // pasien terdaftar
    mapping(address => Patient) public patients;

    // anggap dokter = medical staff
    mapping(address => bool) public medicalStaff;

    // access control
    mapping(address => mapping(address => bool)) public accessControl;

    // timestamp akses
    mapping(address => mapping(address => uint)) public accessTimestamp;

    // event
    event AccessGranted(address patient, address doctor, uint timestamp);

    // PSEUDOCODE
    /*
    FUNCTION grantAccess(_doctor):
      REQUIRE caller (msg.sender) is registered patient
      REQUIRE _doctor is registered medical staff
      SET accessControl[msg.sender][_doctor] = true
      SET accessTimestamp[msg.sender][_doctor] = block.timestamp
      EMIT AccessGranted(msg.sender, _doctor, block.timestamp)
    */

    function grantAccess(address _doctor) public {

        require(
            patients[msg.sender].isRegistered == true,
            "Not registered patient"
        );

        require(
            medicalStaff[_doctor] == true,
            "Doctor not registered"
        );

        accessControl[msg.sender][_doctor] = true;

        accessTimestamp[msg.sender][_doctor] = block.timestamp;

        emit AccessGranted(msg.sender, _doctor, block.timestamp);
    }
}
