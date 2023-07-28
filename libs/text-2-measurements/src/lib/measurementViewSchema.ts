export const VariableCategoryNames = [
  'Emotions',
  'Physique',
  'Physical Activity',
  'Locations',
  'Miscellaneous',
  'Sleep',
  'Social Interactions',
  'Vital Signs',
  'Cognitive Performance',
  'Symptoms',
  'Nutrients',
  'Goals',
  'Treatments',
  'Activities',
  'Foods',
  'Conditions',
  'Environment',
  'Causes of Illness',
  'Books',
  'Software',
  'Payments',
  'Movies and TV',
  'Music',
  'Electronics',
  'IT Metrics',
  'Economic Indicators',
  'Investment Strategies'
] as const;  // 'as const' makes it a readonly array

// Then you can use this array to define your type:
export type VariableCategoryName = typeof VariableCategoryNames[number];  // This will be a union of the array values

export const UnitNames = [
  'per Minute',
  'Yes/No',
  'Units',
  'Torr',
  'Tablets',
  'Sprays',
  'Serving',
  'Seconds',
  'Quarts',
  'Puffs',
  'Pounds',
  'Pills',
  'Pieces',
  'Percent',
  'Pascal',
  'Parts per Million',
  'Ounces',
  'Minutes',
  'Milliseconds',
  'Millimeters Merc',
  'Millimeters',
  'Milliliters',
  'Milligrams',
  'Millibar',
  'Miles per Hour',
  'Miles',
  'Micrograms per decilitre',
  'Micrograms',
  'Meters per Second',
  'Meters',
  'Liters',
  'Kilometers',
  'Kilograms',
  'Kilocalories',
  'International Units',
  'Index',
  'Inches',
  'Hours',
  'Hectopascal',
  'Grams',
  'Gigabecquerel',
  'Feet',
  'Event',
  'Drops',
  'Doses',
  'Dollars',
  'Degrees North',
  'Degrees Fahrenheit',
  'Degrees East',
  'Degrees Celsius',
  'Decibels',
  'Count',
  'Centimeters',
  'Capsules',
  'Calories',
  'Beats per Minute',
  'Applications',
  '1 to 5 Rating',
  '1 to 3 Rating',
  '1 to 10 Rating',
  '0 to 5 Rating',
  '0 to 1 Rating',
  '-4 to 4 Rating',
  '% Recommended Daily Allowance'
] as const;  // 'as const' makes it a readonly array

// Then you can use this array to define your type:
export type UnitName = typeof UnitNames[number];  // This will be a union of the array values


// a set of measurements logged by the user
export type MeasurementSet = {
  measurements: (Measurement | UnknownText)[];
};

export interface Measurement {
  itemType: 'measurement',
  variableName: string;
  value: number;
  unitName: UnitName;
  startAt: string;
  combinationOperation: "SUM" | "MEAN";
  variableCategoryName: VariableCategoryName;
}

// Use this type for measurement items that match nothing else
export interface UnknownText {
  itemType: 'unknown',
  text: string; // The text that wasn't understood
}

export type Food = Measurement & {
  variableCategoryName: "Foods";
  combinationOperation: "SUM";
};

export type Drink = Measurement & {
  variableCategoryName: "Foods";
  combinationOperation: "SUM";
};

export type Treatment = Measurement & {
  variableCategoryName: "Treatments";
  combinationOperation: "SUM";
};

export type Symptom = Measurement & {
  variableCategoryName: "Symptoms";
  combinationOperation: "MEAN";
  unitName: '/5';
};
