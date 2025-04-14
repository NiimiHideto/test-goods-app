-- CreateTable
CREATE TABLE "Session" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "shop" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "isOnline" BOOLEAN NOT NULL DEFAULT false,
    "scope" TEXT,
    "expires" DATETIME,
    "accessToken" TEXT NOT NULL,
    "userId" BIGINT,
    "firstName" TEXT,
    "lastName" TEXT,
    "email" TEXT,
    "accountOwner" BOOLEAN NOT NULL DEFAULT false,
    "locale" TEXT,
    "collaborator" BOOLEAN DEFAULT false,
    "emailVerified" BOOLEAN DEFAULT false
);

-- CreateTable
CREATE TABLE "TagSettings" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "shop" TEXT NOT NULL,
    "sessionId" TEXT NOT NULL,
    "query" TEXT,
    "pageAction" TEXT,
    "startCursor" TEXT,
    "endCursor" TEXT,
    "cache" JSONB
);

-- CreateTable
CREATE TABLE "BoxSettings" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "shop" TEXT NOT NULL,
    "sessionId" TEXT NOT NULL,
    "tags" TEXT,
    "status" TEXT,
    "sort" TEXT,
    "query" TEXT,
    "pageAction" TEXT,
    "startCursor" TEXT,
    "endCursor" TEXT,
    "cache" JSONB
);

-- CreateTable
CREATE TABLE "ProductSettings" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "shop" TEXT NOT NULL,
    "sessionId" TEXT NOT NULL,
    "boxId" INTEGER,
    "boxSort" TEXT,
    "boxQuery" TEXT,
    "boxPageAction" TEXT,
    "boxStartCursor" TEXT,
    "boxEndCursor" TEXT,
    "boxCache" JSONB,
    "tags" TEXT,
    "sort" TEXT,
    "query" TEXT,
    "pageAction" TEXT,
    "startCursor" TEXT,
    "endCursor" TEXT,
    "cache" JSONB
);

-- CreateTable
CREATE TABLE "BoxTag" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "shop" TEXT NOT NULL,
    "tagName" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "ProductTag" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "shop" TEXT NOT NULL,
    "tagName" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "BoxProduct" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "shop" TEXT NOT NULL,
    "productId" BIGINT NOT NULL,
    "title" TEXT NOT NULL,
    "display" BOOLEAN NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "BoxContent" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "shop" TEXT NOT NULL,
    "boxId" INTEGER NOT NULL,
    "rank" INTEGER,
    "productId" BIGINT NOT NULL,
    "variantId" BIGINT,
    "title" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "BoxContent_boxId_fkey" FOREIGN KEY ("boxId") REFERENCES "BoxProduct" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "BoxOrder" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "shop" TEXT NOT NULL,
    "orderNo" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "BoxOrderItem" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "boxOrderId" INTEGER NOT NULL,
    "boxId" INTEGER NOT NULL,
    "productId" BIGINT NOT NULL,
    "variantId" BIGINT NOT NULL,
    "LocationId" BIGINT NOT NULL,
    "ItemId" BIGINT NOT NULL,
    "status" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "BoxOrderItem_boxOrderId_fkey" FOREIGN KEY ("boxOrderId") REFERENCES "BoxOrder" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE INDEX "box_tag_index" ON "BoxTag"("shop", "tagName");

-- CreateIndex
CREATE UNIQUE INDEX "BoxTag_shop_tagName_key" ON "BoxTag"("shop", "tagName");

-- CreateIndex
CREATE INDEX "product_tag_index" ON "ProductTag"("shop", "tagName");

-- CreateIndex
CREATE UNIQUE INDEX "ProductTag_shop_tagName_key" ON "ProductTag"("shop", "tagName");

-- CreateIndex
CREATE INDEX "product_index" ON "BoxProduct"("shop", "productId");

-- CreateIndex
CREATE UNIQUE INDEX "BoxProduct_shop_productId_key" ON "BoxProduct"("shop", "productId");

-- CreateIndex
CREATE INDEX "boxContent_index" ON "BoxContent"("boxId", "productId", "variantId");

-- CreateIndex
CREATE INDEX "boxContent_product_index" ON "BoxContent"("shop", "productId");

-- CreateIndex
CREATE UNIQUE INDEX "BoxContent_boxId_productId_variantId_key" ON "BoxContent"("boxId", "productId", "variantId");

-- CreateIndex
CREATE INDEX "boxOrder_index" ON "BoxOrder"("shop", "orderNo");

-- CreateIndex
CREATE UNIQUE INDEX "BoxOrder_shop_orderNo_key" ON "BoxOrder"("shop", "orderNo");

-- CreateIndex
CREATE INDEX "boxOrderItem_index" ON "BoxOrderItem"("boxOrderId");
