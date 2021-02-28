from sanic import Sanic
from sanic.response import json
from rethinkdb import RethinkDB

r = RethinkDB()

r.connect( "localhost", 28015).repl()
#r.db("test").table_create("bookings").run()

app = Sanic("booking_app")

@app.route("/")
async def test(request):
  return json({"hello": "world"})

@app.post("/bookings")
def post_booking(request):
  id = r.table("bookings").insert(request.json)['generated_keys'][0].run()
  doc = r.table("bookings").get(id).run()
  return json(doc)

@app.get("/bookings")
def get_booking(request):
  # print(request.body)
  cursor = r.table("bookings").run()
  return json(list(cursor))

@app.delete("/bookings/<id>")
def delete_booking(request, id):
  r.table("bookings").get(id).delete().run()
  return response.json(
        {'message': 'Success!'},
        headers={'X-Served-By': 'sanic'},
        status=204
    )

@app.put("/bookings/<id>")
def update_booking(request, id):
  r.table("bookings").get(id).update(request.json).run()
  return response.json(
        {'message': 'Success!'},
        headers={'X-Served-By': 'sanic'},
        status=204
    )



if __name__ == "__main__":
  app.run(host="localhost", port=4000)
