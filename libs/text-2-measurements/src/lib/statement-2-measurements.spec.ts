import * as fs from 'fs';
import * as  path from 'path';
import { processStatement } from './statement-2-measurements';

describe('processRequests', () => {
  const fixture = JSON.parse(fs.readFileSync(path.resolve(__dirname, 'statement-2-measurements.json'), 'utf-8'));
  it('should process statements correctly with type chat', async () => {
    for (const test of fixture) {
      const result = await processStatement(test.statement, test.localDateTime);
      expect(result.measurements).toEqual(test.measurements);
    }
  }, 90000);
});
