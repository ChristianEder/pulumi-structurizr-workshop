import * as infrastructure from '../infrastructure';
import { describe, it } from "mocha";
import { expect } from "chai";

describe("infrastructure", () => {
  describe("web app", () => {
    it("should only support HTTPS requests", (done) => {
      infrastructure.app.httpsOnly.apply(h => { 
        expect(h).to.equal(true);
        done();
       });
    });
  });
});