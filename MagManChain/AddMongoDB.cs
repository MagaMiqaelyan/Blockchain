using MongoDB.Driver;

namespace MagMan
{
    public class AddMongoDB
    {
        private MongoClient dbClient = new MongoClient("mongodb://127.0.0.1:27017");

        public void AddBlock(Block block)
        {
            IMongoDatabase db = dbClient.GetDatabase("Blockchain");
            var collection = db.GetCollection<Block>("ChainOfBlocks");
            collection.InsertOne(block);
        }
    }
}
