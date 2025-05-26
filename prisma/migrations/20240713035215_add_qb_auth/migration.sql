-- CreateTable
CREATE TABLE "QBAuth" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "realmId" TEXT NOT NULL,
    "accessToken" TEXT NOT NULL,
    "refreshToken" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "QBAuth_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "QBAuth_userId_realmId_key" ON "QBAuth"("userId", "realmId");

-- AddForeignKey
ALTER TABLE "QBAuth" ADD CONSTRAINT "QBAuth_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
