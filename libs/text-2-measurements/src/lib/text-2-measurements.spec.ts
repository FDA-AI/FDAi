import * as fs from 'fs';
import * as  path from 'path';
import { processStatement } from './text-2-measurements';

describe('processRequests', () => {
  const fixture = JSON.parse(fs.readFileSync(path.resolve(__dirname, 'fixture.json'), 'utf-8'));
  it('should process statements correctly', async () => {

    for (const test of fixture.tests) {
      const result = await processStatement(test.statement);
      expect(result).toEqual(test.expected);
    }
  }, 60000);

  it('should process a statement correctly v1', async () => {

    for (const test of fixture.tests) {
      const result = await processStatement(test.statement);
      expect(result).toEqual(test.expected);
    }
  }, 15000);
});
