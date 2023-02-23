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
        }
];

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # A resource for generating greetings
    # + name - the input string name
    # + return - string name with hello message or error
    resource function get greeting() returns Item[]|error {
        return itemTable.toArray();
    }

    resource function post greeting(string name) returns string|error {
        // Send a response back to the caller.
        if name is "" {
            return error("name should not be empty!");
        }
        return "Hello, " + name;
    }
}
