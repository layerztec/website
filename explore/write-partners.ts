#!/usr/bin/env bun

import { partnersList } from './sum.ts';

await Bun.write('partners.json', JSON.stringify(partnersList, null, 2) + '\n');

console.log('Wrote partners.json');


