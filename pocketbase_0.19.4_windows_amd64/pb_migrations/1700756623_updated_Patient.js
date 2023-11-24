/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("7auphg0m8ffecml")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "1l1pfgin",
    "name": "CanGoToVital",
    "type": "bool",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {}
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "m21sxh3r",
    "name": "IsTreatmentComplated",
    "type": "bool",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {}
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "6svr1lxn",
    "name": "NumberOfFractionComplated",
    "type": "number",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "noDecimal": false
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "luxxi0rb",
    "name": "NumberOfFractionNeeded",
    "type": "number",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "noDecimal": false
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "9zx4qlmz",
    "name": "TreatmentDuration",
    "type": "number",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "noDecimal": false
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "c4blzz5f",
    "name": "IsTreatmentStarted",
    "type": "bool",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {}
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "3jqlcntu",
    "name": "NextTreatment",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "atody5np5n7l41k",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("7auphg0m8ffecml")

  // remove
  collection.schema.removeField("1l1pfgin")

  // remove
  collection.schema.removeField("m21sxh3r")

  // remove
  collection.schema.removeField("6svr1lxn")

  // remove
  collection.schema.removeField("luxxi0rb")

  // remove
  collection.schema.removeField("9zx4qlmz")

  // remove
  collection.schema.removeField("c4blzz5f")

  // remove
  collection.schema.removeField("3jqlcntu")

  return dao.saveCollection(collection)
})
