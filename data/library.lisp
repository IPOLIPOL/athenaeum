;;;; data/library.lisp
;;;; The authored literature catalogue.
;;;; This is the source of truth. Do not edit generated site/index.html.

;;;; data/library.lisp
;;;; The authored literature catalogue.
;;;; This is the source of truth. Do not edit generated site/index.html.

(in-package #:athenaeum.model)


(defun authors (&rest names)
  (mapcar (lambda (name)
            (make-author
             :id name
             :name name))
          names))


(defun book* (id title &key authors subtitle year publisher edition
                         description url cover category images quotes)
  (make-book
   :id id
   :title title
   :authors (apply #'authors authors)
   :subtitle subtitle
   :year year
   :publisher publisher
   :edition edition
   :description description
   :url url
   :cover cover
   :category category
   :images
   (mapcar (lambda (x)
             (make-image
              :src (first x)
              :alt (second x)
              :caption (third x)))
           images)
   :quotes
   (mapcar (lambda (text)
             (make-literature-quote :text text))
           quotes)))



(defun make-library-data ()
  (let ((it
          (make-category
           :id "it"
           :title "IT"
           :icon "🧮"
           :books
           (list
            (book*
             "organizing-information"
             "Organizing Information"
             :authors '("G. G. Chowdhury" "Sudatta Chowdhury")
             :subtitle "From the Shelf to the Web, 2007"
             :year 2007
             :publisher "Facet Publishing"
             :edition "1st edition"
             :description "Metadata, Markup languages, ontology, information architecture and semantic web"
             :url "https://archive.org/details/organizinginform0000chow/mode/2up"
             :cover "assets/organizing-information.jpg")

            (book*
             "information-architecture"
             "Information Architecture"
             :authors '("Louis Rosenfeld" "Peter Morville" "Jorge Arango")
             :subtitle "For The Web And Beyond, 2015"
             :year 2015
             :publisher "O'Reilly Media"
             :edition "4th edition"
             :description "Information architecture object and principles, user-context-content model, organizing of information, navigation, labeling and search systems, metadata, thesauri, semantic relations and controlled vocabularies, practical implementation approaches"
             :url "https://archive.org/details/louis-rosenfeld-peter-morville-jorge-arango-information-architecture-for-the-web/mode/2up"
             :cover "assets/information architecture o'reilly.jpeg"
             :images
             '(("assets/thesaurus.png" "Thesaurus icon")
               ("assets/Equivalence.png" "Diagram icon")
               ("assets/Hierarchical.png" "Hierarchical network icon")
               ("assets/Associative.png" "Associative network icon")))

            (book*
             "local-area-networks"
             "Local Area Networks"
             :authors '("James Martin with Kathleen Kavanagh Chapman" "Joe Leben")
             :subtitle "Architecture and Implementations, 1994"
             :year 1994
             :publisher "Prentice Hall PTR"
             :edition "2nd edition"
             :description "A narrative about network technologies at the dawn of the internet, many of which are now a thing of the past. The book lacks a coherent plot; the information is presented without the strict system, and many things are repeated in different parts of the book. In this sense, the book feels more like a poorly assembled hodgepodge of different pieces, making it difficult to read. However, the core concepts remain unchanged to this day, such as the OSI Model of Functional Layers and an explanation of operating principles based on it. The Physical layer, Logical Link Control, Medium Access Control, the Ethernet, TCP/IP, the functions of Bridges and Routers are covered in detail. The book provides a general understanding of how the Internet works."
             :url "https://bibliotek.dk/materiale/local-area-networks_martin-j-/work-of:820060-katalog:107860?type=bog&tid=UpUGD17592095291471153406321"
             :cover "assets/LocalAreaNetworks.jpeg")

            (book*
             "ohaskell"
             "О Haskell по человечески"
             :authors '("Шевченко Денис")
             :subtitle "2016; 2nd edition"
             :year 2016
             :description "Неплохая книга чтобы получить первое представление о языке Хаскелл, незаконченная. Книга даст ответы на некоторые вопросы о языке, но далеко не на все, а даже наоборот, после прочтения появятся много новых вопросов."
             :url "https://www.ohaskell.guide/"
             :cover "assets/ОHaskell.jpeg"))))

        (science
          (make-category
           :id "science"
           :title "Science"
           :icon "⚗"
           :books
           (list
            (book*
             "vivid-topology"
             "Наглядная топология"
             :authors '("В. Г. Болтянский" "В. А. Ефремович")
             :year 1982
             :publisher "Наука"
             :description "Топология линий (включая теорию Графов), Топология поверхностей, Гомотопии и гомологии"
             :url "https://wavegenetics.org/f/5.pdf"
             :cover "assets/Vivid_topology1982.jpg")

            (book*
             "logic-automata-algorithms"
             "Логика. Автоматы. Алгоритмы."
             :authors '("Айзерман М. А." "Гусев Л. А." "Розоноэр Л. И." "Смирнова И. М." "Таль А. А.")
             :year 1963
             :publisher "Физматгиз"
             :description "Общая теория конечных автоматов и последовательных машин, Исчисление высказываний и предикатов, Основы теории алгоритмов (рекурсивных функций)"
             :quotes '("Конечная динамическая система назввается конечным автоматом, если состояние системы в каждый такт однозначно определяется: а) состоянием системы в предыдущий такт и б) входом в предыдущий или рассматриваемый такт")
             :url "https://ikfia.ysn.ru/wp-content/uploads/2018/01/AjzermanGusevRozonoerSmirnovaTal1963ru.pdf"
             :cover "assets/Logika_Automats_Algorythms_1963.jpg")

            (book*
             "scientific-progress"
             "Научно-технический прогресс, природа и человек"
             :authors '("Д. П. Никитин" "Ю. В. Новиков" "Г. П. Зарубин")
             :year 1977
             :publisher "Наука"
             :description "Рассматриваются вопросы охраны окружающей среды. Наглядно показываются преимущества социально-планового подхода перед буржуазно-капиталистическим. Книга дает представление о том, чем отличется реальная деятельность и научных подход к защите окружающей среды от навязанных в западном мире политических течений \"экологизма\" и \"зеленой повестки\"."
             :quotes '("Человек отличается от других животных... Это отличие состоит в том, что человек не просто биологический вид, но является составной частью особой социальной среды — общества. Среда человека — это не только природа, она формируется также другими качественно новыми социально-экономическими условиями.")
             :cover "assets/scientific_progress.jpg")

            (book*
             "cybernetics"
             "Кибернетика"
             :authors '("Норберт Винер")
             :subtitle "или управление и связь в животном и машине, 1968"
             :year 1968
             :publisher "Советское радио"
             :description "Книга затрагивает широкий круг вопросов, от сферы наук технических до сферы наук социальных и гуманитарных. Из-за этого в книге нет единой сюжетной линии, это скорее сборник разных мыслей, сдобренный большим кол-вом расчетов. Многие мысли автора актуальны по сей день, многие — нет, в особенности его рассуждения и предсказания о природе мышления и устройстве мозга, поскольку эта область оказалась значительно сложнее и до сих пор большинство вопросов остаются открытыми."
             :quotes '("Информация — это информация, а не материя и не энергия."
                       "Обучающаяся машина — это такая машина, которая не просто, скажем, играет, в какую-нибудь игру по твердым правилам, с неизменной стратегией, но периодически или непрерывно рассматривает результаты этой стратегии, дабы определить, нельзя ли изменить с пользой те или иные параметры, те или иные величины в стратегии.")
             :url "https://psv4.userapi.com/s/v1/d/1VGt79QQIcZMhBj7GvwWU1DO1rQe2FN1O3Y7Y86ZR2NDAMRmSpTP0XPCqqg1U8DFUiC6PpY2wtXhuItXOKkJ3r4IVkWpncLobDc7BjkK5g_O1mfSbA4/Viner_N_Kibernetika_ili_Upravlenie_i_svyaz_v_zhivotnom_i_mashine_1968.pdf"
             :cover "assets/Wiener.jpeg")

            (book*
             "developing-product-families"
             "Developing product families based on architectures"
             :authors '("Harlou, Ulf")
             :subtitle "Contribution to a theory of product families, 2006"
             :year 2006
             :publisher "Technical University of Denmark"
             :description "Thesis for the degree of Doctor of Philosophy. Откровенно слабая дессертационная работа больше похожая на гуманитарный трактат на тему \"продуктовых семейств\" в design theory. Автор попытался обобщить опыт разработки продуктовых семейств из таких компаний как Bang & Olufsen, Vestas, LEGO, Alfa Laval и YORK в некую теорию и даже ввел такие новые термины как Generic Organ Diagram, PFMP, Design Unit (при этом не дав определения элементам входящим в эти понятия). Но по факту все описываемые понятия никак не формализованны, не имеют под собой никакого математического аппарата и поэтому представляют малую практическую и научную ценность. Данный подход в разработке может быть применим только для продуктов, конструкция которых целиком и полностью определяется несколькими функциональными требованиями, которые не зависят от сторонних факторов и их изменение четко предсказуемо. Данный подход не применим к более комплексным и сложным продуктам, конструкция которых зависит не только от функциональных требований, но и от других сторонних факторов, как например специфические требования заказчика, проекта, смежных систем и т.д. По сути этот подход можно применять только к продуктам массового и сериийного типов. Любой нормальный студент 4го курса машиностроительного факультета из СССР или РФ не найдет здесь для себя ничего нового."
             :quotes '("The design is modelled from two constitutive viewpoints – organs and parts. The two constitutive viewpoints are necessary for explaining the behaviour of a design and its physical realisation. The organ models describe the units that possess functions and the parts model describes the physical units that are realised in a sequence of production processes.")
             :url "https://backend.orbit.dtu.dk/ws/portalfiles/portal/6340000/Ulf_Harlou.pdf"
             :cover "assets/pfmp.jpeg")

            (book*
             "product-architecture"
             "The Role of Product Architecture in the Manufacturing Firm"
             :authors '("Ulrich, K. T.")
             :subtitle "1995"
             :year 1995
             :publisher "Elsevier, Vol.24"
             :description "Research Policy. Consise essay describing the two main approaches to the product architecture — integral and modular, with further introducing the sub-types of modularity: slot, bus and sectional — which could be of use. The product architecture as described in the paper is applicable to the mass or serial products which are driven by function/designer decisions. Not applicable for products dependant on external uncontrolled factors (customer or project requirements, external interfaces, etc)."
             :quotes '("In informal terms, the architecture of the product is the scheme by which the function of the product is allocated to physical components.")
             :url "https://ktulrich.com/wp-content/uploads/2022/09/ulrich-architecture-rp.pdf"
             :cover "assets/PArch.jpeg"))))

        (professional
          (make-category
           :id "professional"
           :title "Professional literature"
           :icon "🛠️"
           :books
           (list
            (book*
             "wind-and-its-use"
             "Ветер и его использование"
             :authors '("А. В. Кармишин")
             :year 1951
             :publisher "Гостехиздат"
             :description "Природа и физика ветра, вопросы ветроэнергетики"
             :url "docs/Professional literature/Кармишин А.В. 1951 Ветер и его использование.pdf"
             :cover "assets/Veter_ego_ispolzovanie1951.jpg")

            (book*
             "elektrotechnik"
             "Электротехника кратко и наглядно"
             :authors '("Конрад В.")
             :year 1980
             :publisher "Ленинград \"Энергия\". Ленинградское отделение"
             :description "Физика электричества и магнетизма в рамках школьного курса, краткий обзор электрических машин и оборудования, распределительных сетей"
             :url "https://publ.lib.ru/ARCHIVES/K/KONRAD_Val'ter/_Konrad_V..html"
             :cover "assets/Elektrotechnik.png")

            (book*
             "humanity-and-fires"
             "Человечество и пожары"
             :authors '("Брушлинский Н. Н." "Соколов С. В." "Вагнер П.")
             :year 2007
             :publisher "ИПЦ Маска"
             :description "Исследование о пожарах, их природе, технике их предупреждения и борьбы с ними. Подкреплено статистическими и историческими справочными данными. Книга может быть полезна специалистам из этой сферы."
             :url "https://ptm01.ru/brushlinskij-n.n,,-sokolov-s.v.,-vagner-p.-chelovechestvo-i-pozharyi"
             :cover "assets/chelovechestvo-i-pozharyi.jpeg"))))

        (classical
          (make-category
           :id "classical"
           :title "Classical Literature"
           :icon "🕯️"
           :books nil))

        (popular
          (make-category
           :id "popular"
           :title "Popular"
           :icon "🛋️"
           :books
           (list
            (book*
             "secrets-of-creativity"
             "Тайны творчества"
             :authors '("С. Корнеев")
             :year 1962
             :publisher "Тамбовское книжное издательство"
             :description "Серия Библиотечка новатора. Коротенькая книжка предназначенная для знакомства школьников с теорией решения изобретательских задач (ТРИЗ)."
             :url "https://lib-bkm.ru/14654"
             :cover "assets/TainiT.jpeg")))))
    (make-library
     :title "Athenaeum"
     :categories (list it science professional classical popular))))
