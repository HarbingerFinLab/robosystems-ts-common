/*
  Warnings:

  - You are about to drop the `Company` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `companyId` to the `QBAuth` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Company" DROP CONSTRAINT "Company_qbAuthId_fkey";

-- DropForeignKey
ALTER TABLE "Company" DROP CONSTRAINT "Company_userId_fkey";

-- AlterTable
ALTER TABLE "QBAuth" ADD COLUMN     "companyId" TEXT NOT NULL;

-- DropTable
DROP TABLE "Company";
