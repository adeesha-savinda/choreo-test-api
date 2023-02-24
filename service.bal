import ballerina/http;

public type Item record {|
    readonly int id;
    string name;
    string description;
    string image;
    StockDetail stockDetail;
|};

public type StockDetail record {|
    readonly int id;
    int itemId;
    decimal quantity;
    string intendedFor;
    string color;
    string material;
|};

public final table<Item> key(id) itemTable = table [
    {
            id: 1,
            name: "Top Paw® Valentine's Day Single Dog Sweater",
            description: "Dress your pup up appropriately for Valentine's Day with this Top Paw Valentine's Day Kisses Dog Sweater. This sweet sweater slips on and off easily while offering a comfortable fit, and lets it be known that your pup is single and ready to mingle",
            image: "https://assets3.thrillist.com/v1/image/3110818/382x382/flatten;scale;matte=ffffff=center;webp=auto;jpeg_quality=60.jpg",
            stockDetail: {
                id: 1,
                itemId: 1,
                quantity: 10.0,
                intendedFor: "Dogs",
                color: "Red, White, Black",
                material: "100% Acrylic"
            }
        },
        {
            id: 2,
            name: "Arcadia Trail™ Dog Windbreaker",
            description: "The right jacket for your pet while the two of you are out on the trail together can make all the difference when it comes to both warmth and comfort. This Arcadia Trail Windbreaker zippers shut, features a packable hood, has an opening for a leash, and even comes with a waste bag dispenser and waste bags. Comfortable and versatile, this unique jacket makes a great choice for the outdoor adventures you share with your pup",
            image: "https://www.homesalive.ca/media/catalog/product/c/h/chilly-dog-fairisle-rag-wool-3.jpg",
            stockDetail: {
                id: 1,
                itemId: 2,
                quantity: 7.0,
                intendedFor: "Dogs",
                color: "Pink, Navy",
                material: ""
            }
        }
];

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # A resource for retrieving items 
    # + return - an array of items
    resource function get items() returns Item[]|error {
        return itemTable.toArray();
    }

    resource function post item(string name) returns string|error {
        // Send a response back to the caller.
        if name is "" {
            return error("name should not be empty!");
        }
        return "Hello, " + name;
    }
}
