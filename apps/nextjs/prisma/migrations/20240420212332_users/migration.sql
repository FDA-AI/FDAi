/*
  Warnings:

  - You are about to drop the `activities` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `activity_log` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "activities" DROP CONSTRAINT "activities_user_id_fkey";

-- DropForeignKey
ALTER TABLE "activity_log" DROP CONSTRAINT "activity_log_activity_id_fkey";

-- DropTable
DROP TABLE "activities";

-- DropTable
DROP TABLE "activity_log";
