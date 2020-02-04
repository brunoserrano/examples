pragma solidity >=0.4.25 <0.6.0;

contract DocSign {
    // Set states
    enum StateType { Created, Signed, Active, Paused, Terminated, Canceled }

    // Properties
    StateType public State;
    string public Id1;
    string public Id2;
    string public Hsh;
    string public Url;
    mapping (address => uint) public Participants;
    address public CreatedBy;

    address public Interactor;

    address[] private _participantIds;
    uint private _participantsCount;

    constructor (string memory id1, string memory id2, string memory hsh, string memory url, address createdBy) public {
        Update(id1, id2, hsh, url);

        CreatedBy = createdBy;
        Interactor = msg.sender;

        _participantsCount = 0;
        _participantIds = new address[](_participantsCount);
    }

    function AddParticipant(address participant) public {
        Participants[participant] = 1;

        _participantsCount++;
        _participantIds.push(participant);
    }

    function RemoveParticipant(address participant) public {
        Participants[participant] = 0;
    }

    function Sign(address person) public {
        if (Participants[person] != 1) {
            revert("Participant is not in the 'Sign' state.");
        }

        Participants[person] = 2;

        bool didSign = true;
        for (uint8 index = 0; index < _participantIds.length; index++) {
            if (Participants[_participantIds[index]] != 2) {
                didSign = false;
                break;
            }
        }

        if (didSign) {
            State = StateType.Signed;
        }
    }

    function Activate(address person) public {
        if (person != CreatedBy) {
            revert("Contract can't be activated by this person.");
        }

        State = StateType.Active;
    }

    function Pause(address person) public {
        if (person != CreatedBy) {
            revert("Contract can't be paused by this person.");
        }

        State = StateType.Paused;
    }

    function Terminate(address person) public {
        if (person != CreatedBy) {
            revert("Contract can't be terminated by this person.");
        }

        State = StateType.Terminated;
    }

    function Cancel(address person) public {
        if (person != CreatedBy) {
            revert("Contract can't be canceled by this person.");
        }

        State = StateType.Canceled;
    }

    function Update(string memory id1, string memory id2, string memory hsh, string memory url) public {
        Id1 = id1;
        Id2 = id2;
        Hsh = hsh;
        Url = url;

        State = StateType.Created;

        for (uint8 index = 0; index < _participantIds.length; index++) {
            if (Participants[_participantIds[index]] != 0 && Participants[_participantIds[index]] != 1) {
                Participants[_participantIds[index]] = 1;
            }
        }
    }
}