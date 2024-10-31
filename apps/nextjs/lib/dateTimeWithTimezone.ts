/**
 * Returns the current date and time in UTC with the timezone offset applied.
 *
 * @returns {string} The current date and time in UTC as an ISO string.
 *
 * @example
 * const utcDateTime = getUtcDateTimeWithTimezone();
 * console.log(utcDateTime); // Outputs: "2023-10-01T10:00:00.000Z"
 */
export function getUtcDateTimeWithTimezone(): string {
  const date = new Date();
  const timezoneOffset = date.getTimezoneOffset();
  return new Date(date.getTime() - timezoneOffset * 60000).toISOString();
}

/**
 * Converts a local date-time string to a UTC date-time string.
 *
 * @param localDateTime - The local date-time string in the format "YYYY-MM-DDThh:mm:ss".
 * @param timezoneOffsetInMinutes - The timezone offset in minutes (e.g., -120 for UTC+2).
 * @returns The UTC date-time string in ISO format.
 */
export function convertToUTC(localDateTime: string, timezoneOffsetInMinutes: number): string {
  // Convert the localDateTime string to a Date object
  console.log("local date time being used "+ localDateTime);
  const localDate = new Date(localDateTime);
  console.log("date being used "+ localDate);
  return new Date(localDate.getTime() + timezoneOffsetInMinutes * 60000).toISOString();
}

export function throwErrorIfDateInFuture(utcDateTime: string) {
  const localDate = new Date(utcDateTime);
  const now = new Date();
  if (localDate > now) {
    throw new Error("Date cannot be in the future");
  }
}

/**
 * Retrieves the current date and time in ISO 8601 format, expressed in Coordinated Universal Time (UTC).
 *
 * @return {string} The current date and time in ISO 8601 format, in UTC timezone.
 *
 * @example
 * const currentUtcDateTime = getUtcDateTime();
 * console.log(currentUtcDateTime); // Outputs: "2023-10-01T10:00:00.000Z"
 */
export function getUtcDateTime(): string {
  return new Date().toISOString();
}

export function getTimeZoneOffset(){
  return new Date().getTimezoneOffset();
}

/**
 * Converts a UTC date-time string to a local date-time string.
 *
 * @param {string | number | Date} utcDateTime - The UTC date-time to convert.
 * @param {number} timeZoneOffsetInMinutes - The timezone offset in minutes (e.g., -120 for UTC+2).
 * @returns {string} The local date-time string in ISO format.
 *
 * @example
 * const localDateTime = convertToLocalDateTime("2023-10-01T10:00:00.000Z", -120);
 * console.log(localDateTime); // Outputs: "2023-10-01T08:00:00.000Z"
 */
export function convertToLocalDateTime(
  utcDateTime: string | number | Date,
  timeZoneOffsetInMinutes: number): string {
  const utcDate = new Date(utcDateTime);
  const localDate = new Date(utcDate.getTime() - timeZoneOffsetInMinutes * 60000);
  return localDate.toISOString();
}
