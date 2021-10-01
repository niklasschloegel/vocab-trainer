import 'package:vocab_trainer/models/models.dart';

var categories = [
  Category(
    "Rechnernetze",
    [
      Lesson(
        "Computernetzwerke",
        [
          FileCard(
            "Für was steht RFC?",
            "Request for Comments – Internetstandards",
          ),
          FileCard(
            "Was ist ein Protokoll?",
            "Protokolle definieren das Format und die Reihenfolge in der Nachrichten von Systemen im Netzwerk gesendet und empfangen werden, sowie die Aktionen, welche durch diese Nachrichten ausgelöst werden.",
          ),
          FileCard(
            "Welche 5 Schichten sind Teil des Internet-Protokollstapels? Was sind die Hauptaufgaben dieser Schichten?",
            """
1. Anwendungsschicht: Unterstützt Netwerkanwendung (FTP, HTTP)
2. Transportschicht: Dateitransfer zwischen Prozessen (TCP, UDP)
3. Netzwerkschicht: Weiterleitend der Daten (IP, Routing)
4. Sicherungsschicht: Datentransfer benachbarter Netzwerke (PPP, Ethernet)
5. Bitübertragungsschicht: Bits auf Leitung
          """,
          ),
          FileCard(
            "Inwiefern ist das Internet hierarchisch strukturiert?",
            """
Das Internet ist in Tiers aufgeteilt:

Tier 1: ISPs (Internet Service Providers)
Tier 2: nationale/regionale ISPs
Tier 3: lokale ISPs/Zugangsnetzwerke
        """,
          ),
          FileCard(
            "Wie funktioniert die Paketvermittlung?",
            """
* Pakete teilen sich Netzwerkressourcen, jedes Paket nutzt volle Bandbreite
* Store and Forward = Pakete durchqueren eine Leitung nach der anderen
    > Router empfangen komplettes Paket, bevor sie es weiterleiten
    > Überlast möglich    
        """,
          ),
          FileCard(
            "Wie sieht das ISO/OSI - Referenzmodell aus?",
            """
zwischen Anwendungs- und Transportschicht zusätzlich:
Darstellungsschicht: Anwendung interpretiert Bedeutung von Daten (Verschlüsselung, Kompression)
Kommunikationssteuerungsschicht Synchronisation
        """,
          ),
          FileCard(
            "Was ist Traceroute und wie funktioniert es?",
            """
Traceroute ist ein Programm, welches die Route von einem Endpunkt zum Anderen ermittelt und dabei die Verzögerungen zwischen den einzelnen Routern misst.

Jeder Router sendet dabei drei Paket an den vorherigen Router, welcher daraufhin als Reaktion ein Paket versendet. Der Sender misst dann die Zeit zwischen Versand des eignenen Pakets und Empfang des eingehenden Pakets.
        """,
          ),
          FileCard(
            "Was ist ein Engpass?",
            "Die Leitung auf dem End-to-End Pfad mit dem geringsten Durchsatz, die den Gesamtdurchsatz bestimmt.",
          ),
          FileCard(
            "Was ist der Durchsatz?",
            "Die Rate (Bit/t), mit der Daten zwischen Sender und Empfänger übertragen werden",
          ),
        ],
      ),
      Lesson(
        "Anwendungsschicht",
        [
          FileCard(
            "Wie können Hosts addressiert werden?",
            "Über IP-Addresse + Port",
          ),
          FileCard(
            "Was ist ein Socket?",
            "Eine Kommunikationsschnittstelle zwischen Prozess und Transportdienst (TCP, UDP).",
          ),
          FileCard(
            "Was ist ein Prozess und wie unterscheiden diese sich bei Client und Server?",
            """
Ein Prozess ist ein Programm, welches auf einem Host läuft.
Beim Client beginnt der Prozess die Kommunikation, beim Server wartet der Prozess darauf, kontaktiert zu werden.
            """,
          ),
          FileCard(
            "Beschreibe die Peer-to-Peer Architektur. Nenne ein Vor- und Nachteil.",
            """
Es gibt keine Server, Clients kommunizieren direkt miteinander.
Pro: Da keine Server -> gut skalierbar
Con: Schwer wart-/kontrollierbar
            """,
          ),
          FileCard(
            "Was ist eine Round Trip Time?",
            "Die Zeit, um ein kleines Paket vom Client zum Server und zurück zu schicken.",
          ),
        ],
      ),
      Lesson(
        "Transportschicht",
        [
          FileCard(
            "Wofür sind Transportdienste und -protokolle da",
            "Sie stellen logische Kommunikation zwischen Anwendungsprozessen auf verschiedenen Hosts zur Verfügung",
          ),
          FileCard(
            "Was ist Demultiplexing?",
            "Empfänger empfängt IP-Datagramme, enthalten Absender- und Empfänger IP-Adresse und Portnummer. Hosts nutzen IP&Port, um Segmente an richtigen Socket zu leiten",
          ),
          FileCard(
            "Was ist der 3-Wege-Handshake?",
            """
1. Client sendet TCP-SYN-Segment an Server mit initialer Sequenznummer
2. Server empfängt SYN und antwortet mit SYNACK und Sequenznummer, legt Puffer an
3. Client empfängt SYNACK und antwortet mit ACK (darf schon Nachrichten erhalten)
            """,
          ),
        ],
      ),
      Lesson(
        "Netzwerkschicht",
        [],
      ),
      Lesson(
        "Sicherungsschicht",
        [],
      ),
    ],
  ),
  Category(
    "Englisch Vokabeln",
    [
      Lesson(
        "Standartlektion",
        [
          FileCard("(to) go", "gehen"),
          FileCard("(to) jump", "springen"),
          FileCard("duck", "Ente"),
          FileCard("water", "Wasser"),
          FileCard("brain", "Gehirn"),
        ],
      ),
    ],
  ),
];
