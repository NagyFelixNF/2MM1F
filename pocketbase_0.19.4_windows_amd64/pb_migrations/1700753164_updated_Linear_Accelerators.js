/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("2cr9mgwuw1r88nv")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "whwrrpee",
    "name": "Name",
    "type": "text",
    "required": false,
    "presentable": true,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("2cr9mgwuw1r88nv")

  // remove
  collection.schema.removeField("whwrrpee")

  return dao.saveCollection(collection)
})
