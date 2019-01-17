const SafeMathMcok = artifacts.require("SafeMathMock");

contract("SafeMathMcok", async accounts => {
  let safeMath;

  before(async function() {
    safeMath = await SafeMathMcok.deployed();
  });

  it("should valid 3 plus 8", async () => {
    let result = await safeMath.add(3, 8);
    assert.equal(11, result);
  });

  it("should invalid 3 plus -8", async () => {
    let result = await safeMath.add(3, -8);
    assert.notEqual(-5, result);
  });

  it("is equal to 8 minus 3", async () => {
    let result = await safeMath.sub(8, 3);
    assert.equal(5, result);
  });

  it("is not equal to 3 minus 8", async () => {
    try {
      await safeMath.sub(3, 8);
    } catch (error) {
      assert.equal(
        error.message,
        "Returned error: VM Exception while processing transaction: revert"
      );
    }
  });
});
