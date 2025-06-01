-- CreateTable
CREATE TABLE "UserGraph" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "graphId" TEXT NOT NULL,
    "graphName" TEXT NOT NULL,
    "role" TEXT NOT NULL DEFAULT 'ADMIN',
    "isSelected" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserGraph_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "UserGraph_userId_idx" ON "UserGraph"("userId");

-- CreateIndex
CREATE INDEX "UserGraph_graphId_idx" ON "UserGraph"("graphId");

-- CreateIndex
CREATE INDEX "UserGraph_userId_isSelected_idx" ON "UserGraph"("userId", "isSelected");

-- CreateIndex
CREATE UNIQUE INDEX "UserGraph_userId_graphId_key" ON "UserGraph"("userId", "graphId");

-- CreateIndex
CREATE INDEX "APIKey_graphId_idx" ON "APIKey" USING HASH ("graphId");

-- AddForeignKey
ALTER TABLE "UserGraph" ADD CONSTRAINT "UserGraph_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
