/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("atody5np5n7l41k")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "10259yse",
    "name": "field",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "7auphg0m8ffecml",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("atody5np5n7l41k")

  // remove
  collection.schema.removeField("10259yse")

  return dao.saveCollection(collection)
})
