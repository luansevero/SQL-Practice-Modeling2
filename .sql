CREATE TABLE "public.customers" (
	"id" serial NOT NULL,
	"name" TEXT(60) NOT NULL,
	"email" TEXT NOT NULL UNIQUE,
	"cpf" varchar(11) NOT NULL UNIQUE,
	"password" TEXT(30) NOT NULL,
	CONSTRAINT "customers_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.customerAddresses" (
	"id" serial NOT NULL,
	"customerId" integer NOT NULL,
	"street" TEXT NOT NULL,
	"numbeer" integer NOT NULL,
	"complement" TEXT NOT NULL,
	"postalCode" TEXT NOT NULL,
	"cityId" integer NOT NULL,
	"districtId" integer NOT NULL,
	CONSTRAINT "customerAddresses_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.cities" (
	"id" serial NOT NULL,
	"name" TEXT NOT NULL UNIQUE,
	"statesId" integer NOT NULL,
	CONSTRAINT "cities_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.states" (
	"id" serial NOT NULL,
	"name" TEXT NOT NULL,
	CONSTRAINT "states_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.districts" (
	"id" serial NOT NULL,
	"name" TEXT NOT NULL,
	CONSTRAINT "districts_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.customerCreditCards" (
	"id" serial NOT NULL,
	"customerPaymentId" integer NOT NULL,
	"cardFlag" TEXT NOT NULL,
	"securityCode" varchar(3) NOT NULL,
	"expirationMont" varchar(2) NOT NULL,
	"expirationYear" varchar(4) NOT NULL,
	"number" varchar(16) NOT NULL,
	CONSTRAINT "customerCreditCards_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.products" (
	"id" serial NOT NULL,
	"name" TEXT NOT NULL,
	"category" TEXT NOT NULL,
	"price" integer NOT NULL,
	"size" TEXT,
	"mainImageId" integer NOT NULL,
	"stock" integer,
	CONSTRAINT "products_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.receipt" (
	"id" serial NOT NULL,
	"customerId" integer NOT NULL,
	"paymentId" serial NOT NULL,
	"paymentState" serial NOT NULL DEFAULT 'created',
	CONSTRAINT "receipt_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.customerCart" (
	"id" serial NOT NULL,
	"customerId" integer NOT NULL,
	"productsId" integer NOT NULL,
	CONSTRAINT "customerCart_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.payment" (
	"id" serial NOT NULL,
	"customerAdressesId" integer NOT NULL,
	"customerId" integer NOT NULL,
	"customerCartId" integer NOT NULL,
	"paymentCard" integer NOT NULL,
	CONSTRAINT "payment_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.productsImages" (
	"id" serial NOT NULL,
	"productId" integer NOT NULL,
	"image" TEXT NOT NULL,
	"main" BOOLEAN NOT NULL,
	CONSTRAINT "productsImages_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.customersPayment" (
	"id" serial NOT NULL,
	"customerId" integer NOT NULL,
	CONSTRAINT "customersPayment_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);




ALTER TABLE "customerAddresses" ADD CONSTRAINT "customerAddresses_fk0" FOREIGN KEY ("customerId") REFERENCES "customers"("id");
ALTER TABLE "customerAddresses" ADD CONSTRAINT "customerAddresses_fk1" FOREIGN KEY ("cityId") REFERENCES "cities"("id");
ALTER TABLE "customerAddresses" ADD CONSTRAINT "customerAddresses_fk2" FOREIGN KEY ("districtId") REFERENCES "districts"("id");

ALTER TABLE "cities" ADD CONSTRAINT "cities_fk0" FOREIGN KEY ("statesId") REFERENCES "states"("id");



ALTER TABLE "customerCreditCards" ADD CONSTRAINT "customerCreditCards_fk0" FOREIGN KEY ("customerPaymentId") REFERENCES "customersPayment"("id");

ALTER TABLE "products" ADD CONSTRAINT "products_fk0" FOREIGN KEY ("mainImageId") REFERENCES "productsImages"("id");

ALTER TABLE "receipt" ADD CONSTRAINT "receipt_fk0" FOREIGN KEY ("customerId") REFERENCES "customers"("id");
ALTER TABLE "receipt" ADD CONSTRAINT "receipt_fk1" FOREIGN KEY ("paymentId") REFERENCES "payment"("id");

ALTER TABLE "customerCart" ADD CONSTRAINT "customerCart_fk0" FOREIGN KEY ("customerId") REFERENCES "customers"("id");
ALTER TABLE "customerCart" ADD CONSTRAINT "customerCart_fk1" FOREIGN KEY ("productsId") REFERENCES "products"("id");

ALTER TABLE "payment" ADD CONSTRAINT "payment_fk0" FOREIGN KEY ("customerAdressesId") REFERENCES "customerAddresses"("id");
ALTER TABLE "payment" ADD CONSTRAINT "payment_fk1" FOREIGN KEY ("customerId") REFERENCES "customers"("id");
ALTER TABLE "payment" ADD CONSTRAINT "payment_fk2" FOREIGN KEY ("customerCartId") REFERENCES "customerCart"("id");
ALTER TABLE "payment" ADD CONSTRAINT "payment_fk3" FOREIGN KEY ("paymentCard") REFERENCES "customerCreditCards"("id");

ALTER TABLE "productsImages" ADD CONSTRAINT "productsImages_fk0" FOREIGN KEY ("productId") REFERENCES "products"("id");

ALTER TABLE "customersPayment" ADD CONSTRAINT "customersPayment_fk0" FOREIGN KEY ("customerId") REFERENCES "customers"("id");












