from datetime import date, datetime
from multiprocessing.dummy import Array
from faker import Faker
import random
import csv
from wonderwords import RandomWord

furnitureTypesCount = 36

furnitureTypes = []

userCount = 100

manufacturersCount = 100

ordersCount = 100

privelegiesCount = 4

furnitureCount = 1000



def fillTable(columnNames: list, tableEntities: list, csvFileName: str):
    outputCsv = open(csvFileName, "w", newline='')
    csvWriter = csv.writer(outputCsv)
    csvWriter.writerow(columnNames)
    csvWriter.writerows(tableEntities)


def generateUser(faker: Faker, currentId: int):
    userSample = []
    userSample.append(currentId)
    userSample.append(faker.unique.name())
    userSample.append(faker.unique.user_name())
    userSample.append(faker.unique.free_email())
    userSample.append(faker.unique.password())
    userSample.append(faker.unique.city())
    return userSample

def generateManufacturer(fakerRu: Faker, currentId: int):
    isAvailable = [True, False]
    manufacturerSample = []
    manufacturerSample.append(currentId)
    manufacturerSample.append(fakerRu.kpp())
    manufacturerSample.append(fakerRu.businesses_inn())
    manufacturerSample.append(random.randint(1, 10))
    manufacturerSample.append(random.randint(1, 1000))
    manufacturerSample.append(random.choice(isAvailable))
    return manufacturerSample

def generateUserInfo(faker: Faker, currentId: int):
    userInfo = []
    userInfo.append(currentId)
    userInfo.append(random.randint(0, furnitureTypesCount - 1))
    userInfo.append(random.randint(0, 50000))
    userInfo.append(str(faker.date_time_this_year()))
    userInfo.append(str(faker.date_of_birth(minimum_age=16, maximum_age=70)))
    userInfo.append(random.randint(0, privelegiesCount - 1))
    userInfo.append(currentId)
    return userInfo


def generateCsvWithManufacturers(count: int):
    columnNames = ['id', 'KPP', 'INN', 'reliability', 'distance', 'availability']
    allManufacturers = []
    faker = Faker("ru_RU")
    for i in range(count):
        allManufacturers.append(generateManufacturer(faker, i))

    fillTable(columnNames, allManufacturers, "csv/manufacturers.csv")

def generateCsvWithFurnitureTypes():
    normalList = []
    columnNames = ["id", "name"]
    id = 0
    for line in open("src/furnitureTypes.txt", "r"):
        if '[' in line:
            normalList.append([id, line.split("[")[0].lower().strip()])
            id += 1
    fillTable(columnNames, normalList, "csv/types.csv")
    global furnitureTypesCount
    furnitureTypesCount = len(normalList)
    global furnitureTypes
    furnitureTypes = normalList

def generateCsvWithUsers(count: int):
    columnNames = ['id', 'name', 'login', 'email', 'password', 'City']
    allUsers = []
    faker = Faker()
    for i in range(count):
        allUsers.append(generateUser(faker, i))

    fillTable(columnNames, allUsers, "csv/users.csv")

def generateCsvWithUserInfo():
    columnNames = ["id", "favorite_furniture_type", "purchase_sum", "last_visit_date", "birthday", "privileges_id", "fk_user"]
    allUserInfos = []
    faker = Faker()
    for i in range(userCount):
        allUserInfos.append(generateUserInfo(faker, i))

    fillTable(columnNames, allUserInfos, "csv/users_info.csv")

def generateCsvWithFurniture(count):
    wordsGenerator = RandomWord()
    wordsList = wordsGenerator.random_words(count)
    allFurniture = []
    columnNames = ["id", "name", "fk_furniture_type", "fk_manufacturer", "price", "available_count", "discount"]
    for id in range(count):
        furnitureSample = []
        furnitureSample.append(id) # id
        furnitureSample.append(wordsList[id] + '_' + furnitureTypes[id % furnitureTypesCount][1]) # name
        furnitureSample.append(random.randint(0, furnitureTypesCount - 1)) # fk_furniture_type
        furnitureSample.append(random.randint(0, manufacturersCount - 1)) # fk_manufacturer
        furnitureSample.append(random.randint(100, 100_000)) # price
        furnitureSample.append(random.randint(0, 1000)) # available_count
        furnitureSample.append(random.randint(0, 30)) # discount
        allFurniture.append(furnitureSample)
    fillTable(columnNames, allFurniture, "csv/furniture.csv")

def generateCsvWithOrder(count):
    columnNames = ["id", "fk_user", "price", "creation_date", "address"]
    orders = []
    faker = Faker()

    for i in range(count):
        orderSample = []
        orderSample.append(i)
        orderSample.append(random.randint(0, userCount - 1))
        orderSample.append(0)
        orderSample.append(str(faker.date_this_month()))
        orderSample.append(faker.address().replace("\n", " "))
        orders.append(orderSample)

    fillTable(columnNames, orders, "csv/order.csv")

def generateCsvWithOrderFurniture(count):
    columnNames = ["fk_order", "fk_furniture", "qty"]

    allSamples = []

    orders = [x for x in range(ordersCount)]
    furniture = [x for x in range(furnitureCount)]

    random.shuffle(orders)
    random.shuffle(furniture)

    for i in range(count):
        orderFurnitureSample = []
        orderFurnitureSample.append(orders[i])
        orderFurnitureSample.append(furniture[i])
        orderFurnitureSample.append(random.randint(1, 10))
        allSamples.append(orderFurnitureSample)

    fillTable(columnNames, allSamples, "csv/order_furniture.csv")

def generateCsvWithOrderFurniture(count):
    columnNames = ["fk_order", "fk_furniture", "qty"]

    allSamples = []

    orders = [x for x in range(ordersCount)]
    furniture = [x for x in range(furnitureCount)]

    random.shuffle(orders)
    random.shuffle(furniture)

    for i in range(count):
        orderFurnitureSample = []
        orderFurnitureSample.append(orders[i])
        orderFurnitureSample.append(furniture[i])
        orderFurnitureSample.append(random.randint(1, 10))
        allSamples.append(orderFurnitureSample)

    fillTable(columnNames, allSamples, "csv/order_furniture.csv")

def generateCsvWithUsage():
    columnNames = ["id", "fk_user", "name"]
    allSamples = []

    fake = Faker()
    
    for i in range(userCount):
        usageSample = []
        usageSample.append(i)
        usageSample.append(i)
        usageSample.append(str(fake.credit_card_number()))
        allSamples.append(usageSample)
    fillTable(columnNames, allSamples, "csv/defend.csv")


# generateCsvWithUsers(10)
# generateCsvWithManufacturers(10)
# generateCsvWithFurnitureTypes()
# generateCsvWithManufacturers(100)
# generateCsvWithUsers(100)
# print(furnitureTypesCount)

# generateCsvWithFurnitureTypes()
# generateCsvWithManufacturers(200)
# generateCsvWithUsers(1000)
# generateCsvWithUserInfo()
# generateCsvWithFurniture(furnitureCount)
# generateCsvWithOrder(ordersCount)
# generateCsvWithOrderFurniture(80)

generateCsvWithUsage()
#
