-- CreateTable
CREATE TABLE "PlaidAuth" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "itemId" TEXT NOT NULL,
    "accessToken" TEXT NOT NULL,
    "publicToken" TEXT,
    "accountIds" TEXT[],
    "institutionId" TEXT NOT NULL,
    "institutionName" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PlaidAuth_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "PlaidAuth_itemId_idx" ON "PlaidAuth" USING HASH ("itemId");

-- CreateIndex
CREATE UNIQUE INDEX "PlaidAuth_userId_itemId_key" ON "PlaidAuth"("userId", "itemId");

-- AddForeignKey
ALTER TABLE "PlaidAuth" ADD CONSTRAINT "PlaidAuth_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
