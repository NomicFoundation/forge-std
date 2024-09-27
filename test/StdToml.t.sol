// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "../src/Test.sol";

contract StdTomlTest is Test {
    using stdToml for string;

    string root;
    string readPath;
    string writePath;

    function setUp() public {
        root = vm.projectRoot();
        readPath = string.concat(root, "/test/fixtures/testRead.toml");
        writePath = string.concat(root, "/test/fixtures/testWrite.toml");
    }

    struct SimpleToml {
        uint256 a;
        string b;
    }

    struct NestedToml {
        uint256 a;
        string b;
        SimpleToml c;
    }

    function test_readToml() public view {
        string memory json = vm.readFile(readPath);
        assertEq(json.readUint(".a"), 123);
    }

    function test_writeToml() public {
        string memory json = "json";
        json.serialize("a", uint256(123));
        string memory semiFinal = json.serialize("b", string("test"));
        string memory finalJson = json.serialize("c", semiFinal);
        finalJson.write(readPath);

        string memory toml = vm.readFile(readPath);
        bytes memory data = toml.parseRaw("$");
        NestedToml memory decodedData = abi.decode(data, (NestedToml));

        assertEq(decodedData.a, 123);
        assertEq(decodedData.b, "test");
        assertEq(decodedData.c.a, 123);
        assertEq(decodedData.c.b, "test");
    }
}
