// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedChain {

    struct Patient {
        address patientAddress;
        string name;
        string dob;
        string nik;
        bool isRegistered;
        uint registeredAt;
    }

    mapping(address => Patient) public patients;
    mapping(address => bool) public authorizedRegistrar;

    address public admin;

    event PatientRegistered(address patientAddress, string name, uint timestamp);

    constructor() {
        admin = msg.sender;
    }

    // PSEUDOCODE
    /*
    FUNCTION registerPatient(_patientAddress, _name, _dob, _nik):
      REQUIRE caller is admin OR authorized registrar
      REQUIRE patient[_patientAddress] does NOT exist
      CREATE patient record:
        { address, name, dob, nik, isRegistered: true, registeredAt: block.timestamp }
      STORE patient record in patients mapping
      EMIT PatientRegistered(_patientAddress, _name, block.timestamp)
    */

    function registerPatient(
        address _patientAddress,
        string memory _name,
        string memory _dob,
        string memory _nik
    ) public {
        require(
            msg.sender == admin || authorizedRegistrar[msg.sender],
            "Not authorized"
        );

        require(
            !patients[_patientAddress].isRegistered,
            "Patient already exists"
        );

        patients[_patientAddress] = Patient(
            _patientAddress,
            _name,
            _dob,
            _nik,
            true,
            block.timestamp
        );

        emit PatientRegistered(_patientAddress, _name, block.timestamp);
    }
}
