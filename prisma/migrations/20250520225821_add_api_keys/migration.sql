-- CreateTable
CREATE TABLE "APIKey" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "key" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "lastUsedAt" TIMESTAMP(3),
    "expiresAt" TIMESTAMP(3),
    "isActive" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "APIKey_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "APIKey_key_key" ON "APIKey"("key");

-- CreateIndex
CREATE INDEX "APIKey_key_idx" ON "APIKey" USING HASH ("key");

-- CreateIndex
CREATE INDEX "APIKey_userId_idx" ON "APIKey" USING HASH ("userId");

-- AddForeignKey
ALTER TABLE "APIKey" ADD CONSTRAINT "APIKey_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
