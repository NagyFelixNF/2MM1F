/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "2cr9mgwuw1r88nv",
    "created": "2023-11-23 15:18:26.917Z",
    "updated": "2023-11-23 15:18:26.917Z",
    "name": "Linear_Accelerators",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "gschc9p1",
        "name": "Type",
        "type": "select",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "maxSelect": 1,
          "values": [
            "TrueBeam",
            "VitalBeam",
            "Clinac1"
          ]
        }
      },
      {
        "system": false,
        "id": "1tpmfvlk",
        "name": "Starting_hour",
        "type": "date",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "min": "",
          "max": ""
        }
      },
      {
        "system": false,
        "id": "gkt5r8xl",
        "name": "Ending_hour",
        "type": "date",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "min": "",
          "max": ""
        }
      }
    ],
    "indexes": [],
    "listRule": null,
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {}
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("2cr9mgwuw1r88nv");

  return dao.deleteCollection(collection);
})
