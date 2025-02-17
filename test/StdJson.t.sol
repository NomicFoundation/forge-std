// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import {Test, stdJson} from "../src/Test.sol";

contract StdJsonTest is Test {
    using stdJson for string;

    string root;
    string readPath;
    string writePath;

    function setUp() public {
        root = vm.projectRoot();
        readPath = string.concat(root, "/test/fixtures/testRead.json");
        writePath = string.concat(root, "/test/fixtures/testWrite.json");
    }

    struct SimpleJson {
        uint256 a;
        string b;
    }

    struct NestedJson {
        uint256 a;
        string b;
        SimpleJson c;
    }

    function test_readJson() public view {
        string memory json = vm.readFile(readPath);
        assertEq(json.readUint(".a"), 123);
    }

    function test_writeJson() public {
        string memory json = "json";
        json.serialize("a", uint256(123));
        string memory semiFinal = json.serialize("b", string("test"));
        string memory finalJson = json.serialize("c", semiFinal);
        finalJson.write(writePath);

        string memory json_ = vm.readFile(writePath);
        bytes memory data = json_.parseRaw("$");
        NestedJson memory decodedData = abi.decode(data, (NestedJson));

        assertEq(decodedData.a, 123);
        assertEq(decodedData.b, "test");
        assertEq(decodedData.c.a, 123);
        assertEq(decodedData.c.b, "test");
    }
}
