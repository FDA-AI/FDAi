import * as fs from 'fs';
import * as  path from 'path';
import { processStatement } from './text-2-measurements';  // Substitute with your actual import

describe('processRequests', () => {
  it('should process a  statement correctly', async () => {
    const fixture = JSON.parse(fs.readFileSync(path.resolve(__dirname, 'fixture.json'), 'utf-8'));

    for (const test of fixture.tests) {
      const result = await processStatement(test.statement);
      expect(result).toEqual(test.expected);
    }
  }, 15000);
});
