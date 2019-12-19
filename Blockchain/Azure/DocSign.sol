pragma solidity >=0.4.25 <0.6.0;

contract DocSign {
    // Set states
    enum StateType { Created, Signed, Active, Inactive }

    // Properties
    StateType public State;
    string public Id1;
    string public Id2;
    string public Hsh;
    string public Url;
    address public Contractor;
    address public Contracted;
    address public Testifier;
    address public CreatedBy;
    bool public ContractorDidSign;
    bool public ContractedDidSign;
    bool public TestifierDidSign;

    constructor (string memory id1, string memory id2, string memory hsh, string memory url,
      address contractor, address contracted, address testifier) public {

        Id1 = id1;
        Id2 = id2;
        Hsh = hsh;
        Url = url;
        Contractor = contractor;
        Contracted = contracted;
        Testifier = testifier;

        State = StateType.Created;
        CreatedBy = msg.sender;
    }

    function Sign() public {
        if (msg.sender == Contractor && !ContractorDidSign) {
            ContractorDidSign = true;
        }
        else if (msg.sender == Contracted && !ContractedDidSign) {
            ContractedDidSign = true;
        }
        else if (msg.sender == Testifier && !TestifierDidSign) {
            TestifierDidSign = true;
        }
        else {
            revert("Contract can't be signed by this person.");
        }

        if (ContractorDidSign && ContractedDidSign && TestifierDidSign) {
            State = StateType.Signed;
        }
    }

    function Activate() public {
        if (msg.sender != CreatedBy) {
            revert("Contract can't be activated by this person.");
        }

        State = StateType.Active;
    }

    function Inactivate() public {
        if (msg.sender != CreatedBy) {
            revert("Contract can't be inactivated by this person.");
        }

        State = StateType.Inactive;
    }
}