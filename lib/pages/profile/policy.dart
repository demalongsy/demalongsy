import 'package:bulleted_list/bulleted_list.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:flutter/material.dart';

class PolicyPage extends StatefulWidget {
  const PolicyPage({super.key});

  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: C.white,
        appBar: AppBar(
          backgroundColor: C.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  child: const Icon(
                    Icons.close_rounded,
                    color: C.dark2,
                    size: 30.0,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Spectral(
                  overflow: false,
                  text: 'Privacy Policy of De\'malongsy',
                  size: 36,
                  color: C.dark1,
                  fontWeight: FW.bold,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text: 'Lasted edit: April 2023',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                ),
              ),
              const SizedBox(height: 12),
              const Divider(color: C.boderAddPhotos),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text: 'Types of Data collected',
                  size: 18,
                  color: C.dark1,
                  fontWeight: FW.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                margin: const EdgeInsets.only(top: 4.0),
                child: const Poppins(
                  overflow: false,
                  text:
                      'The owner does not provide a list of Personal Data types collected.',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text:
                      'Complete details on each type of Personal Data collected are provided in the dedicated sections of this privacy policy or by specific explanation texts displayed prior to the Data collection.Personal Data may be freely provided by the User, or, in case of Usage Data, collected automatically when using this Application.Unless specified otherwise, all Data requested by this Application is mandatory and failure to provide this Data may make it impossible for this Application to provide its services. In cases where this Application specifically states that some Data is not mandatory, Users are free not to communicate this Data without consequences to the availability or the functioning of the Service.Users who are uncertain about which Personal Data is mandatory are welcome to contact the Owner.Any use of Cookies – or of other tracking tools — by this Application or by the owners of third-party services used by this Application serves the purpose of providing the Service required by the User, in addition to any other purposes described in the present document and in the Cookie Policy, if available. Users are responsible for any third-party Personal Data obtained, published or shared through this Application and confirm that they have the third party\'s consent to provide the Data to the Owner.',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(color: C.boderAddPhotos),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text: 'Types of Data collected',
                  size: 18,
                  color: C.dark1,
                  fontWeight: FW.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text: 'Methods of processing',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                margin: const EdgeInsets.only(top: 4.0),
                child: const Poppins(
                  overflow: false,
                  text:
                      'The Owner takes appropriate security measures to prevent unauthorized access, disclosure, modification, or unauthorized destruction of the Data.The Data processing is carried out using computers and/or IT enabled tools, following organizational procedures and modes strictly related to the purposes indicated. In addition to the Owner, in some cases, the Data may be accessible to certain types of persons in charge, involved with the operation of this Application (administration, sales, marketing, legal, system administration) or external parties (such as third-party technical service providers, mail carriers, hosting providers, IT companies, communications agencies) appointed, if necessary, as Data Processors by the Owner. The updated list of these parties may be requested from the Owner at any time.',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text: 'Legal basis of processing',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.bold,
                  textAlign: TextAlign.justify,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                margin: const EdgeInsets.only(top: 4.0),
                child: const Poppins(
                  overflow: false,
                  text:
                      'The Owner may process Personal Data relating to Users if one of the following applies:',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: BulletedList(
                  bullet: Icon(
                    Icons.lens_rounded,
                    color: C.dark1,
                    size: 4,
                  ),
                  bulletColor: C.dark1,
                  listItems: [
                    Poppins(
                      overflow: false,
                      text:
                          'Users have given their consent for one or more specific purposes. Note: Under some legislations the Owner may be allowed to process Personal Data until the User objects to such processing (“opt-out”), without having to rely on consent or any other of the following legal bases. This, however, does not apply, whenever the processing of Personal Data is subject to European data protection law;',
                      size: 14,
                      color: C.dark1,
                      fontWeight: FW.regular,
                      textAlign: TextAlign.justify,
                    ),
                    Poppins(
                      overflow: false,
                      text:
                          'provision of Data is necessary for the performance of an agreement with the User and/or for any pre-contractual obligations thereof;',
                      size: 14,
                      color: C.dark1,
                      fontWeight: FW.regular,
                      textAlign: TextAlign.justify,
                    ),
                    Poppins(
                      overflow: false,
                      text:
                          'processing is necessary for compliance with a legal obligation to which the Owner is subject;',
                      size: 14,
                      color: C.dark1,
                      fontWeight: FW.regular,
                      textAlign: TextAlign.justify,
                    ),
                    Poppins(
                      overflow: false,
                      text:
                          'processing is related to a task that is carried out in the public interest or in the exercise of official authority vested in the Owner;',
                      size: 14,
                      color: C.dark1,
                      fontWeight: FW.regular,
                      textAlign: TextAlign.justify,
                    ),
                    Poppins(
                      overflow: false,
                      text:
                          'processing is necessary for the purposes of the legitimate interests pursued by the Owner or by a third party.',
                      size: 14,
                      color: C.dark1,
                      fontWeight: FW.regular,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                margin: const EdgeInsets.only(top: 4.0),
                child: const Poppins(
                  overflow: false,
                  text:
                      'In any case, the Owner will gladly help to clarify the specific legal basis that applies to the processing, and in particular whether the provision of Personal Data is a statutory or contractual requirement, or a requirement necessary to enter into a contract.',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                margin: const EdgeInsets.only(top: 5.0),
                child: const Poppins(
                  overflow: false,
                  text: 'Place',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                margin: const EdgeInsets.only(top: 4.0),
                child: const Poppins(
                  overflow: false,
                  text:
                      'The Data is processed at the Owner\'s operating offices and in any other places where the parties involved in the processing are located.',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text:
                      'Depending on the User\'s location, data transfers may involve transferring the User\'s Data to a country other than their own. To find out more about the place of processing of such transferred Data, Users can check the section containing details about the processing of Personal Data.',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text:
                      'Users are also entitled to learn about the legal basis of Data transfers to a country outside the European Union or to any international organization governed by public international law or set up by two or more countries, such as the UN, and about the security measures taken by the Owner to safeguard their Data.',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text:
                      'If any such transfer takes place, Users can find out more by checking the relevant sections of this document or inquire with the Owner using the information provided in the contact section.',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                margin: const EdgeInsets.only(top: 5.0),
                child: const Poppins(
                  overflow: false,
                  text: 'Retention time',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                margin: const EdgeInsets.only(top: 4.0),
                child: const Poppins(
                  overflow: false,
                  text:
                      'Personal Data shall be processed and stored for as long as required by the purpose they have been collected for.',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text: 'Therefore:',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                ),
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: BulletedList(
                  bullet: Icon(
                    Icons.lens_rounded,
                    color: C.dark1,
                    size: 4,
                  ),
                  bulletColor: C.dark1,
                  listItems: [
                    Poppins(
                      overflow: false,
                      text:
                          'Personal Data collected for purposes related to the performance of a contract between the Owner and the User shall be retained until such contract has been fully performed.',
                      size: 14,
                      color: C.dark1,
                      fontWeight: FW.regular,
                      textAlign: TextAlign.justify,
                    ),
                    Poppins(
                      overflow: false,
                      text:
                          'Personal Data collected for the purposes of the Owner’s legitimate interests shall be retained as long as needed to fulfill such purposes. Users may find specific information regarding the legitimate interests pursued by the Owner within the relevant sections of this document or by contacting the Owner.',
                      size: 14,
                      color: C.dark1,
                      fontWeight: FW.regular,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text:
                      'The Owner may be allowed to retain Personal Data for a longer period whenever the User has given consent to such processing, as long as such consent is not withdrawn. Furthermore, the Owner may be obliged to retain Personal Data for a longer period whenever required to do so for the performance of a legal obligation or upon order of an authority.',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text:
                      'Once the retention period expires, Personal Data shall be deleted. Therefore, the right of access, the right to erasure, the right to rectification and the right to data portability cannot be enforced after expiration of the retention period.',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(color: C.boderAddPhotos),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text: 'The rights of Users',
                  size: 18,
                  color: C.dark1,
                  fontWeight: FW.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text:
                      'Users may exercise certain rights regarding their Data processed by the Owner.',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text:
                      'In particular, Users have the right to do the following, to the extent permitted by law:',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                ),
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: BulletedList(
                  bullet: Icon(
                    Icons.lens_rounded,
                    color: C.dark1,
                    size: 4,
                  ),
                  bulletColor: C.dark1,
                  listItems: [
                    Poppins(
                      overflow: false,
                      text:
                          'Withdraw their consent at any time. Users have the right to withdraw consent where they have previously given their consent to the processing of their Personal Data.',
                      size: 14,
                      color: C.dark1,
                      fontWeight: FW.regular,
                      textAlign: TextAlign.justify,
                    ),
                    Poppins(
                      overflow: false,
                      text:
                          'Object to processing of their Data. Users have the right to object to the processing of their Data if the processing is carried out on a legal basis other than consent. Further details are provided in the dedicated section below.',
                      size: 14,
                      color: C.dark1,
                      fontWeight: FW.regular,
                      textAlign: TextAlign.justify,
                    ),
                    Poppins(
                      overflow: false,
                      text:
                          'Access their Data. Users have the right to learn if Data is being processed by the Owner, obtain disclosure regarding certain aspects of the processing and obtain a copy of the Data undergoing processing.',
                      size: 14,
                      color: C.dark1,
                      fontWeight: FW.regular,
                      textAlign: TextAlign.justify,
                    ),
                    Poppins(
                      overflow: false,
                      text:
                          'Verify and seek rectification. Users have the right to verify the accuracy of their Data and ask for it to be updated or corrected.',
                      size: 14,
                      color: C.dark1,
                      fontWeight: FW.regular,
                      textAlign: TextAlign.justify,
                    ),
                    Poppins(
                      overflow: false,
                      text:
                          'Restrict the processing of their Data. Users have the right to restrict the processing of their Data. In this case, the Owner will not process their Data for any purpose other than storing it.',
                      size: 14,
                      color: C.dark1,
                      fontWeight: FW.regular,
                      textAlign: TextAlign.justify,
                    ),
                    Poppins(
                      overflow: false,
                      text:
                          'Have their Personal Data deleted or otherwise removed. Users have the right to obtain the erasure of their Data from the Owner.',
                      size: 14,
                      color: C.dark1,
                      fontWeight: FW.regular,
                      textAlign: TextAlign.justify,
                    ),
                    Poppins(
                      overflow: false,
                      text:
                          'Receive their Data and have it transferred to another controller. Users have the right to receive their Data in a structured, commonly used and machine readable format and, if technically feasible, to have it transmitted to another controller without any hindrance.',
                      size: 14,
                      color: C.dark1,
                      fontWeight: FW.regular,
                      textAlign: TextAlign.justify,
                    ),
                    Poppins(
                      overflow: false,
                      text:
                          'Lodge a complaint. Users have the right to bring a claim before their competent data protection authority.',
                      size: 14,
                      color: C.dark1,
                      fontWeight: FW.regular,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text: 'Details about the right to object to processing',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                margin: const EdgeInsets.only(top: 5.0),
                child: const Poppins(
                  overflow: false,
                  text:
                      'Where Personal Data is processed for a public interest, in the exercise of an official authority vested in the Owner or for the purposes of the legitimate interests pursued by the Owner, Users may object to such processing by providing a ground related to their particular situation to justify the objection.',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                margin: const EdgeInsets.only(top: 5.0),
                child: const Poppins(
                  overflow: false,
                  text:
                      'Users must know that, however, should their Personal Data be processed for direct marketing purposes, they can object to that processing at any time, free of charge and without providing any justification. Where the User objects to processing for direct marketing purposes, the Personal Data will no longer be processed for such purposes. To learn whether the Owner is processing Personal Data for direct marketing purposes, Users may refer to the relevant sections of this document.',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text: 'How to exercise these rights',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text:
                      'Any requests to exercise User rights can be directed to the Owner through the contact details provided in this document. These requests can be exercised free of charge and will be answered by the Owner as early as possible and always within one month, providing Users with the information required by law. Any rectification or erasure of Personal Data or restriction of processing will be communicated by the Owner to each recipient, if any, to whom the Personal Data has been disclosed unless this proves impossible or involves disproportionate effort. At the Users’ request, the Owner will inform them about those recipients.',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(color: C.boderAddPhotos),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text:
                      'Additional information about Data collection and processing',
                  size: 18,
                  color: C.dark1,
                  fontWeight: FW.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text: 'Legal action',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text:
                      'The User\'s Personal Data may be used for legal purposes by the Owner in Court or in the stages leading to possible legal action arising from improper use of this Application or the related Services.The User declares to be aware that the Owner may be required to reveal personal data upon request of public authorities.',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text: 'Additional information about User\'s Personal Data',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text:
                      'In addition to the information contained in this privacy policy, this Application may provide the User with additional and contextual information concerning particular Services or the collection and processing of Personal Data upon request.',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text: 'System logs and maintenance',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text:
                      'For operation and maintenance purposes, this Application and any third-party services may collect files that record interaction with this Application (System logs) or use other Personal Data (such as the IP Address) for this purpose.',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text: 'Information not contained in this policy',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text:
                      'More details concerning the collection or processing of Personal Data may be requested from the Owner at any time. Please see the contact information at the beginning of this document.',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text: 'How “Do Not Track” requests are handled',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text:
                      'This Application does not support “Do Not Track” requests.To determine whether any of the third-party services it uses honor the “Do Not Track” requests, please read their privacy policies.',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text: 'Changes to this privacy policy',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text:
                      'The Owner reserves the right to make changes to this privacy policy at any time by notifying its Users on this page and possibly within this Application and/or - as far as technically and legally feasible - sending a notice to Users via any contact information available to the Owner. It is strongly recommended to check this page often, referring to the date of the last modification listed at the bottom.',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Poppins(
                  overflow: false,
                  text:
                      'Should the changes affect processing activities performed on the basis of the User’s consent, the Owner shall collect new consent from the User, where required.',
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.regular,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
