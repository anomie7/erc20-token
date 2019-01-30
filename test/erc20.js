const ERC20MOCK = artifacts.require("ERC20MOCK");

contract("ERC20", async accounts => {
  let erc20;
  beforeEach(async function() {
    erc20 = await ERC20MOCK.deployed();
  });

  describe("totalSupply", function() {
    it("return the total tokens", async () => {
      assert.equal("mainToken", await erc20.name());
      assert.equal("MK", await erc20.symbol());
      assert.equal(1000, await erc20.totalSupply());
    });
  });

  describe("balanceOf", function() {
    it("return the total amount of tokens", async () => {
      assert.equal(1000, await erc20.balanceOf(accounts[0]));
    });
  });

  describe("allowance", function() {
    describe("when initcialized", function() {
      it("return zero", async () => {
        assert.equal(0, await erc20.allowance(accounts[0], accounts[1]));
      });
    });

    describe("approve", function() {
      it("should get first accounts allowance of spender after approve", async () => {
        erc20.approve(accounts[1], 100, { from: accounts[3] });
        assert.equal(100, await erc20.allowance(accounts[3], accounts[1]));
      });
    });

    describe("increaseAllowance", function() {
      it("return 100", async () => {
        erc20.increaseAllowance(accounts[1], 100, {
          from: accounts[3]
        });
        assert.equal(200, await erc20.allowance(accounts[3], accounts[1]));
      });
    });

    describe("decreaseAllowance", function() {
      it("return 100", async () => {
        erc20.decreaseAllowance(accounts[1], 100, { from: accounts[3] });
        assert.equal(100, await erc20.allowance(accounts[3], accounts[1]));
      });
    });
  });

  describe("transfer", function() {
    it("should transfer token amount 100 to second account from first account", async () => {
      await erc20.transfer(accounts[1], 1000);
      assert.equal(1000, await erc20.balanceOf(accounts[1]));
    });

    after(async function() {
      erc20.burn(accounts[1], 1000);
    });
  });

  describe("transferFrom", function() {
    before(async function() {
      erc20.mint(accounts[0], 1000);
      erc20.approve(accounts[1], 1000);
    });

    it("should second account transfer token amount 100 to third account from first account deposit", async () => {
      erc20.transferFrom(accounts[0], accounts[2], 1000, {
        from: accounts[1]
      });
      assert.equal(1000, await erc20.balanceOf(accounts[2]));
      assert.equal(0, await erc20.allowance(accounts[0], accounts[1]));
    });

    after(async function() {
      erc20.burn(accounts[2], 1000);
    });
  });

  describe("burn", function() {
    before(async function() {
      erc20.mint(accounts[0], 1000);
    });

    it("first accounts tokens less than balance", async () => {
      erc20.burn(accounts[0], 1000);
      assert.equal(0, await erc20.balanceOf(accounts[0]));
    });

    it("revert", async () => {
      try {
        erc20.burn(address(0), 100);
      } catch (error) {
        assert.isOk(true);
      }
    });
  });

  describe("burnFrom", function() {
    before(async function() {
      erc20.mint(accounts[0], 1000);
      erc20.approve(accounts[1], 1000);
    });

    it("when second account bure From first account", async () => {
      //when
      erc20.burnFrom(accounts[0], 1000, { from: accounts[1] });

      //then
      assert.equal(0, await erc20.balanceOf(accounts[0]));
      assert.equal(0, await erc20.allowance(accounts[0], accounts[1]));
    });
  });
});
