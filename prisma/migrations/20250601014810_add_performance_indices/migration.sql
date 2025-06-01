-- CreateIndex
CREATE INDEX "APIKey_key_isActive_expiresAt_idx" ON "APIKey"("key", "isActive", "expiresAt");

-- CreateIndex
CREATE INDEX "APIKey_key_graphId_isActive_idx" ON "APIKey"("key", "graphId", "isActive");

-- CreateIndex
CREATE INDEX "APIKey_userId_isActive_idx" ON "APIKey"("userId", "isActive");

-- CreateIndex
CREATE INDEX "Account_userId_idx" ON "Account"("userId");

-- CreateIndex
CREATE INDEX "PlaidAuth_userId_idx" ON "PlaidAuth"("userId");

-- CreateIndex
CREATE INDEX "PlaidAuth_userId_companyId_idx" ON "PlaidAuth"("userId", "companyId");

-- CreateIndex
CREATE INDEX "QBAuth_userId_idx" ON "QBAuth"("userId");

-- CreateIndex
CREATE INDEX "Session_userId_idx" ON "Session"("userId");

-- CreateIndex
CREATE INDEX "Session_expires_idx" ON "Session"("expires");

-- CreateIndex
CREATE INDEX "User_email_idx" ON "User" USING HASH ("email");
