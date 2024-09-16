/**
 * @jest-environment node
 */
import {foodOrDrugCostBenefitAnalysis, safeUnapprovedDrugs} from "@/lib/fdaiAgent";
beforeAll(async () => {
});
describe("FDAi Tests", () => {
    it("cost-benefit analysis", async () => {
        const result = await foodOrDrugCostBenefitAnalysis("NMN");
        console.log(result);
    }, 45000);
    it("safe unapproved drugs", async () => {
        const safeUnapproved = await safeUnapprovedDrugs();
        console.log(safeUnapproved);
    }, 45000);
});
