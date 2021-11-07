# Popug Jira. Actors. Commands. Events. Queries

## Требования
#### Authentication
* Авторизация в таск-трекере/аккаунтинге/аналитике должна выполняться через общий сервис авторизации UberPopug Inc
    * Actor
        * User
    * Command
        * AuthenticateUser
* Создание пользователя
    * Actor
        * Manager/Admin
    * Command
        * CreateUser
    * Event
        * UserCreated
* Изменение роли пользователя
    * Actor
        * Manager/Admin
    * Command
        * ChangeUserRole
    * Event
        * UserRoleChanged

#### Task tracker
* Новые таски может создавать кто угодно
    * 1
      * Actor
          * User
      * Command
          * CreateTask
      * Event
          * TaskCreated
    * 2
      * Actor
        * TaskCreated
      * Command
          * AssignTask
      * Event
          * TaskAssigned
* Должны иметь кнопку «заассайнить задачи», которая возьмёт все открытые задачи и рандомно заассайнит каждую на любого из сотрудников
    * Actor
        * Manager/Admin
    * Command
        * AssignTasks
        * команда будет генерировать отдельный event для каждой задачи
    * Event
        * TaskAssigned
* Каждый сотрудник должен иметь возможность видеть в отдельном месте список заассайненных на него задач
    * Query
        * GetUserTasks
* Отметить задачу выполненной
    * Actor
        * User
    * Command
        * CompleteTask
    * Event
        * TaskCompleted

#### Аккаунтинг
* деньги списываются сразу после ассайна на сотрудника
    * Actor
        * Accounting
    * Command
        * WriteOffBalance
    * Event
        * BalanceWrittenOff
* деньги начисляются после выполнения задачи
    * Actor
        * Accounting
    * Command
        * TopUpBalance
    * Event
        * BalanceTopedUp
* выводить количество заработанных топ-менеджментом за сегодня денег
    * Query
        * GetTasksSumForToday
* в конце дня отправлять на почту сумму выплаты
  * 1
      * Actor
          * Accounting Scheduler
      * Command
          * CloseBillingCycle
      * Event
          * BillingCycleClosed
  * 2 
    * Actor
        * BillingCycleClosed
    * Command
        * PayMoney
    * Event
        * MoneyPayed
  * 3
      * Actor
          * MoneyPayed
      * Command
          * NotifyUser
      * Event
          * UserNotified

#### Аналитика
* показать сколько заработал топ-менеджмент за сегодня
    * Query
        * GetTasksSumForToday
* показать сколько попугов ушло в минус
    * Query
        * GetUsersWithNegativeBalanceCount
*  показывать самую дорогую задачу за
    * день
        * Query
            * GetTheMostExpensiveTaskPerDay
    * неделю
        * Query
            * GetTheMostExpensiveTaskPerWeek
    * месяц
        * Query
            * GetTheMostExpensiveTaskPerMonth


#### Event storming
![Event storming](assets/Popug%20Jira.%20@somenugget.png)
[Lucidchart](https://lucid.app/lucidchart/aa2ccdb3-8328-47ae-bd24-3b83cf35efdf/edit?invitationId=inv_3d8208ff-3fc2-4c9d-947c-270da3247e8c)


#### Модель данных
![Модель данных](assets/Popug%20Jira.%20@somenugget%20-%20Data.png)
[Lucidchart](https://lucid.app/lucidchart/aa2ccdb3-8328-47ae-bd24-3b83cf35efdf/edit?viewport_loc=-1318%2C-331%2C4214%2C2113%2CdGKokMdYCRs-&invitationId=inv_3d8208ff-3fc2-4c9d-947c-270da3247e8c)
