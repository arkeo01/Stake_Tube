/************Part of project demonstrated at ETHIndia 2.0************/
/*******************Kindly mention suitable Credits******************/
// Team : CH3-O-CH3
// Version : beta
// requires are not analyzed
// ipfs to be implemented
// repeated viewer not implemented
pragma solidity ^0.5.7;

contract Attention {
    uint initialViewFee = 10 ether;
    address payable owner = 0xed1e55870F62f65d158227460F4C2C7A2FcFF2b1;

    struct Video {
        string name;
        string description;         //Other COmplementary things like date n all can be implemented
        uint videoId;               //More advanced functionality like category can also be implemented
        //address payable creatorId;
        address payable[] users;
        //string ipfsHash;          //To be implemented Later
        //bool isPrivate;
    }

    uint public videoNos;
    mapping (uint => Video) public videos;

    // Including users and Videos array hence no need to declare a constructor
    event videoAdded(
        uint videoId,
        address payable creatorId
    );

    function addVideo(string memory _name, string memory _description) public {            //EVENT FOR VIDEO ADDITION TO BE CREATED
        //require(bytes(_name).length != 0, "Name of the Video cannot be Empty");
        videoNos++;
        uint _videoId = videoNos;
        Video memory video = Video(
            _name,
            _description,
            _videoId,
            new address payable[](1)
        );
        video.users[0] = msg.sender;
        videos[_videoId] = video;
        emit videoAdded(_videoId, msg.sender);
    }

    function videoEarnings(uint _videoId) public payable {    //address need not be given as input msg.sender can be used
        Video storage videoClicked = videos[_videoId];              //SOME SERIOUS REFACTORING NEEDED
        //require(msg.sender != videoClicked.creatorId);

        uint views = videoClicked.users.length - 1;
        //videoClicked.creatorId.transfer(initialViewFee/2);
        owner.transfer(initialViewFee/80);      //5% of value for the company
        videoClicked.users[0].transfer(9*initialViewFee/20);
        uint deno = views*(views + 1)/2;
        uint fraction = 0;
        uint num = 0;
        for(uint i = 1; i < videoClicked.users.length; i++){
            num = views - (i - 1);
            fraction = num/deno;
            videoClicked.users[i].transfer(fraction * initialViewFee / 2);
        }

        videoClicked.users.push(msg.sender);                      //Check Whether the user is already in the users List
        //Persisting Video and User
        videos[_videoId] = videoClicked;
    }

    function displayViews(uint _videoId) public view returns(uint) {
        return videos[_videoId].users.length - 1;
    }
}
