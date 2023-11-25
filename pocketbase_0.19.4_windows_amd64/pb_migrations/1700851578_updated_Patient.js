/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("7auphg0m8ffecml")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "pprfzmda",
    "name": "CancerType",
    "type": "text",
    "required": false,
    "presentable": false,
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
  const collection = dao.findCollectionByNameOrId("7auphg0m8ffecml")

  // remove
  collection.schema.removeField("pprfzmda")

  return dao.saveCollection(collection)
})
