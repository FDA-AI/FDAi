const parameters = [
  "AAMY", "AFP", "ALB", "ALP", "ALT", "AST", "ATLYMPH", "BASO%", "BILID", "BILIT", "BUN",
  "CA", "CHOLT", "CL", "CREA", "EOS%", "ESR", "FERR", "GGT", "GLC", "GLOBT", "HCT", "HDL",
  "HGB", "HGBA1C", "IRON", "K+", "LDL", "LYMPH%", "MCH", "MCHC", "MCV", "MONO%", "MPV",
  "NA+", "NEUTR%", "P", "PDW", "PLT", "PROT", "RBC", "RDW", "TRIG", "UA", "WBC",
];

export function getBloodScanPrompt() {
  return `Extract blood parameters, their values, range of values,
    and the unit in which each parameter is measured. Ensure utmost precision as we require 100% accuracy.
    Return the response in JSON format with keys being the English abbreviations of the parameter names.
    Each value should be represented as a map with keys 'value,' 'range,' and 'unit.'
    Only include blood parameters listed in ${parameters}. Do not return anything other than JSON.
    Here is an example of a response:
    """
        {
        "AAMY": {
            "value": 50.0,
            "range": "25.0 - 125.0",
            "unit": "u/l"
        },
        "AFP": {
            "value": 3.0,
            "range": "0.0 - 8.3",
            "unit": "u/ml"
        },
        "ALB": {
            "value": 4.6,
            "range": "3.6 - 5.1",
            "unit": "g/l"
        },
        "ALP": {
            "value": 50.0,
            "range": "36 - 130",
            "unit": "IU/L"
        },
        "ALT": {
            "value": 21.0,
            "range": "9 - 46",
            "unit": "IU/L"
        },
        "AST": {
            "value": 26.0,
            "range": "10 - 40",
            "unit": "IU/L"
        },
        "ATLYMPH": {
            "value": 3.0,
            "range": "0 - 12",
            "unit": "%"
        },
        "BASO%": {
            "value": 0.7,
            "range": "0.0 - 1.0",
            "unit": "%"
        },
        "BILID": {
            "value": 3.0,
            "range": "0.0 - 6.84",
            "unit": "umol/l"
        },
        "BILIT": {
            "value": 1.0,
            "range": "0.60 - 1.35",
            "unit": "umol/l"
        },
        "BUN": {
            "value": 4.0,
            "range": "2.5 - 6.43",
            "unit": "mmol/l"
        },
        "CA": {
            "value": 2.3,
            "range": "2.05 - 2.64",
            "unit": "mmol/l"
        },
        "CHOLT": {
            "value": 120.0,
            "range": "100 - 110",
            "unit": "mmol/l"
        },
        "CL": {
            "value": 108.0,
            "range": "98 - 110",
            "unit": "mmol/l"
        },
        "CREA": {
            "value": 50.0,
            "range": "45.0 - 90.0",
            "unit": "umol/l"
        },
        "EOS%": {
            "value": 4.0,
            "range": "1.0 - 4.0",
            "unit": "%"
        },
        "ESR": {
            "value": 15.0,
            "range": "0.0 - 30.0",
            "unit": "mm/hr"
        },
        "FERR": {
            "value": 300.0,
            "range": "24.72 - 689.83",
            "unit": "ug/l"
        },
        "GGT": {
            "value": 20.0,
            "range": "5.0 - 40.0",
            "unit": "u/l"
        },
        "GLC": {
            "value": 4.0,
            "range": "3.61 - 5.55",
            "unit": "mmol/l"
        },
        "GLOBT": {
            "value": 30.0,
            "range": "23.0 - 35.0",
            "unit": "g/l"
        },
        "HCT": {
            "value": 41.0,
            "range": "38.5 - 50.0",
            "unit": "%"
        },
        "HDL": {
            "value": 2.0,
            "range": "1.0 - 2.7",
            "unit": "mmol/l"
        },
        "HGB": {
            "value": 130.0,
            "range": "120.0 - 160.0",
            "unit": "g/l"
        },
        "HGBA1C": {
            "value": 4.0,
            "range": "3.9 - 5.3",
            "unit": "%"
        },
        "IRON": {
            "value": 10.0,
            "range": "6.63 - 25.97",
            "unit": "umol/l"
        },
        "K+": {
            "value": 4.0,
            "range": "3.5 - 5.3",
            "unit": "mmol/l"
        },
        "LDL": {
            "value": 3.0,
            "range": "2.0 - 5.3",
            "unit": "mmol/l"
        },
        "LYMPH%": {
            "value": 34.8,
            "range": "20.0 - 40.0",
            "unit": "%"
        },
        "MCH": {
            "value": 31.0,
            "range": "27.0 - 33.0",
            "unit": "pg"
        },
        "MCHC": {
            "value": 330.0,
            "range": "320.0 - 360.0",
            "unit": "g/l"
        },
        "MCV": {
            "value": 96.0,
            "range": "80.0 - 100.0",
            "unit": "fl"
        },
        "MONO%": {
            "value": 7.4,
            "range": "2.0 - 8.0",
            "unit": "%"
        },
        "MPV": {
            "value": 8.0,
            "range": "7.5 - 12.5",
            "unit": "fl"
        },
        "NA+": {
            "value": 136.0,
            "range": "135 - 146",
            "unit": "mmol/l"
        },
        "NEUTR%": {
            "value": 60.0,
            "range": "55.0 - 73.0",
            "unit": "%"
        },
        "P": {
            "value": 1.0,
            "range": "0.97 - 1.45",
            "unit": "mmol/l"
        },
        "PDW": {
            "value": 13.0,
            "range": "10.0 - 17.9",
            "unit": "%"
        },
        "PLT": {
            "value": 350.0,
            "range": "140 - 400",
            "unit": "thousand/ul"
        },
        "PROT": {
            "value": 70.0,
            "range": "60.0 - 80.0",
            "unit": "g/l"
        },
        "RBC": {
            "value": 4.2,
            "range": "4.20 - 5.80",
            "unit": "x10e9/L"
        },
        "RDW": {
            "value": 12.6,
            "range": "11.0 - 15.0",
            "unit": "%"
        },
        "TRIG": {
            "value": 1.3,
            "range": "0.85 - 1.84",
            "unit": "mmol/l"
        },
        "UA": {
            "value": 0.3,
            "range": "0.12 - 0.42",
            "unit": "mmol/l"
        },
        "WBC": {
            "value": 5.5,
            "range": "4.1 - 10.9",
            "unit": "x10e9/L"
        }
    }
    """
    Values and ranges should never contain words and letters, only numbers and characters like ">" and "<".
    Most of the blood tests are structured in a way where all the information for one parameter is horizontally in the same row but in different columns so make sure to not mix them up since they are all close together and its easy to read a parameter from another row.
    Be very careful with differentiating between the number 5 and 8.
    Pay close attention to dots as they hold significant importance. Their presence or absence, and correct placement, can greatly impact the outcome.
    Be exceptionally precise and avoid speculation. If uncertain about a value, range, or unit in the context of blood test analysis, refrain from providing information rather than presenting inaccurate details. Achieving accuracy is paramount in this task.
    Ensure that there are no keys in response that arent in ${parameters}.
    Additionally, the value must be specific and cannot be checked, but the unit must match the example provided.
    The acceptable range should resemble the example provided, though it need not be an exact match, as it may vary depending on the laboratory.
    The range should include numbers and special characters, excluding words and letters. For instance, if the example range is 'recommendation < 5.0,' ensure that the provided range does not include the word 'recommendation' but only '< 5.0.'
    When assessing the similarity of the range, consider the units; for example, 0.0 - 5.5mmol/l is equivalent to 0.0 - 0.0055mol/l.
    This example illustrates the expected structure, and no additional text beyond the JSON format is required.`;
}
