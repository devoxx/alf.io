{{>/event/page-top}}


 <script src="{{request.contextPath}}/resources/bower_components/jquery/dist/jquery.min.js"></script>
 <script src="{{request.contextPath}}/resources/js/h5f/h5f.min.js"></script>
 <script src="{{request.contextPath}}/resources/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
 <script src="{{request.contextPath}}/resources/js/event/bootstrap-handler.js"></script>
 <script src="{{request.contextPath}}/resources/js/event/reservation-page.js" ></script>

<script src="{{request.contextPath}}/resources/js/event/attendee-form.js"></script>
<script src="{{request.contextPath}}/resources/js/countdownjs/countdown.min.js"></script>
{{>/event/header}}

<div class="wizard wMarginBottom wMarginTop center">
    <a><span class="badge">1</span> <span class="hidden-xs">{{#i18n}}breadcrumb.step1{{/i18n}}</span></a>
    <a class="current"><span class="badge badge-inverse">2</span> {{#i18n}}breadcrumb.step2{{/i18n}}</a>
    <a><span class="badge">3</span> <span class="hidden-xs">{{#i18n}}breadcrumb.step3{{/i18n}}</span></a>
    <a><span class="badge">4</span> <span class="hidden-xs">{{#i18n}}breadcrumb.step4{{/i18n}}</span></a>
</div>

{{#hasErrors}}
    {{#error.globalErrors}}
        <div class="alert alert-danger" role="alert">
            <p><strong>{{#i18n}}{{.}}{{/i18n}}</strong></p>
        </div>
    {{/error.globalErrors}}
{{/hasErrors}}

<div class="alert alert-info text-center">
    <i class="fa fa-clock-o"></i>
    <span id="validity-container"><span data-validity="{{reservation.validity.time}}"
          data-message="{{#i18n}}reservation-page.time-for-completion{{/i18n}}"
          data-message-time-elapsed="{{#i18n}}error.STEP_2_ORDER_HAS_EXPIRED{{/i18n}}"
          data-labels-singular="{{#i18n}}reservation-page.time-for-completion.labels.singular{{/i18n}}"
          data-labels-plural="{{#i18n}}reservation-page.time-for-completion.labels.plural{{/i18n}}"
          data-labels-and="{{#i18n}}reservation-page.time-for-completion.labels.and{{/i18n}}"
          id="validity"></span>
    </span>
</div>

<form action="{{request.contextPath}}/event/{{event.shortName}}/reservation/{{reservation.id}}/validate-to-overview" method="POST" id="payment-form">

    {{^paypalCheckoutConfirmation}}

    <div class="page-header">
        <h2>{{#i18n}}reservation-page.your-details{{/i18n}}</h2>
    </div>
        {{#useFirstAndLastName}}
        <div class="row">
            <div class="col-xs-12 col-sm-6">
                <div class="form-group {{#field-has-error}}[firstName] has-error{{/field-has-error}}">
                    <label for="first-name" class="control-label">{{#i18n}}common.first-name{{/i18n}}</label>
                    <input type="text" name="firstName" id="first-name" required class="form-control {{#attendeeAutocompleteEnabled}}autocomplete-src{{/attendeeAutocompleteEnabled}}" autocomplete="fname" maxlength="255" value="{{paymentForm.firstName}}">
                    {{#field-has-error}}[firstName]<span class="help-block text-danger">{{#i18n}}{{#field-error}}firstName{{/field-error}}{{/i18n}}</span>{{/field-has-error}}
                </div>
            </div>
            <div class="col-xs-12 col-sm-6">
                <div class="form-group {{#field-has-error}}[lastName] has-error{{/field-has-error}}">
                    <label for="last-name" class="control-label">{{#i18n}}common.last-name{{/i18n}}</label>
                    <input type="text" name="lastName" id="last-name" required class="form-control {{#attendeeAutocompleteEnabled}}autocomplete-src{{/attendeeAutocompleteEnabled}}" autocomplete="lname" maxlength="255" value="{{paymentForm.lastName}}">
                    {{#field-has-error}}[lastName]<span class="help-block text-danger">{{#i18n}}{{#field-error}}lastName{{/field-error}}{{/i18n}}</span>{{/field-has-error}}
                </div>
            </div>
        </div>
        {{/useFirstAndLastName}}
        {{^useFirstAndLastName}}
        <div class="form-group {{#field-has-error}}[fullName] has-error{{/field-has-error}}">
            <label for="full-name" class="control-label">{{#i18n}}common.full-name{{/i18n}}</label>
            <input type="text" name="fullName" id="full-name" required class="form-control {{#attendeeAutocompleteEnabled}}autocomplete-src{{/attendeeAutocompleteEnabled}}" autocomplete="name" maxlength="255" value="{{paymentForm.fullName}}">
            {{#field-has-error}}[fullName]<span class="help-block text-danger">{{#i18n}}{{#field-error}}fullName{{/field-error}}{{/i18n}}</span>{{/field-has-error}}
        </div>
        {{/useFirstAndLastName}}


        <div class="row">
            <div class="col-xs-12 {{#captchaRequestedFreeOfCharge}}col-md-6{{/captchaRequestedFreeOfCharge}}">
                <div class="form-group {{#field-has-error}}[email] has-error{{/field-has-error}}">
                    <label for="email" class="control-label">{{#i18n}}common.email{{/i18n}}</label>
                    <input type="email" name="email" id="email" required class="form-control {{#attendeeAutocompleteEnabled}}autocomplete-src{{/attendeeAutocompleteEnabled}}" autocomplete="email" maxlength="255" value="{{paymentForm.email}}">
                    {{#field-has-error}}[email]<span class="help-block text-danger">{{#i18n}}{{#field-error}}email{{/field-error}}{{/i18n}}</span>{{/field-has-error}}
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="billingAddressCompany">{{#i18n}}reservation-page-complete.company{{/i18n}}</label>
                    <input id="billingAddressCompany" name="billingAddressCompany" class="form-control" type="text" value="{{paymentForm.billingAddressCompany}}">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="billingAddressLine1">{{#i18n}}reservation-page.address-line-1{{/i18n}}</label>
                    <input id="billingAddressLine1" name="billingAddressLine1" class="form-control" type="text" required value="{{paymentForm.billingAddressLine1}}">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="billingAddressLine2">{{#i18n}}reservation-page.address-line-2{{/i18n}}</label>
                    <input id="billingAddressLine2" name="billingAddressLine2" class="form-control" type="text" value="{{paymentForm.billingAddressLine2}}">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12 col-md-4">
                <div class="form-group">
                    <label for="billingAddressZip">{{#i18n}}reservation-page.zip-postal-code{{/i18n}}</label>
                    <input id="billingAddressZip" name="billingAddressZip" class="form-control" type="text" required value="{{paymentForm.billingAddressZip}}">
                </div>
            </div>
            <div class="col-xs-12 col-md-8">
                    <div class="form-group">
                        <label for="billingAddressCity">{{#i18n}}reservation-page.city{{/i18n}}</label>
                        <input id="billingAddressCity" name="billingAddressCity" class="form-control" type="text" required value="{{paymentForm.billingAddressCity}}">
                    </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12 {{#customerReferenceEnabled}}col-md-6{{/customerReferenceEnabled}}">
                <div class="form-group">
                    <label for="vatCountry">{{#i18n}}reservation-page-complete.country{{/i18n}}</label>

                    <select name="vatCountryCode" id="vatCountry" value="{{paymentForm.vatCountryCode}}" class="form-control field-required" required>
                        <option value="">{{#i18n}}reservation-page.country.select{{/i18n}}</option>
                        <optgroup label="{{#i18n}}reservation-page.eu-countries{{/i18n}}" id="optgroup-eu-countries-list">
                            {{#euCountriesForVat}}
                                <option value="{{left}}" data-description="{{right}}">{{left}} - {{right}}</option>
                            {{/euCountriesForVat}}
                        </optgroup>
                        <optgroup label="{{#i18n}}reservation-page.all-countries{{/i18n}}">
                            {{#countriesForVat}}
                                <option value="{{left}}" data-description="{{right}}">{{left}} - {{right}}</option>
                            {{/countriesForVat}}
                        </optgroup>
                    </select>
                </div>

            </div>
            {{#customerReferenceEnabled}}
            <div class="col-xs-12 col-md-6">
                <div class="form-group {{#field-has-error}}[customerReference] has-error{{/field-has-error}}">
                    <label for="customerReference" class="control-label">{{#i18n}}common.customer-reference{{/i18n}}</label>
                    <input type="text" name="customerReference" id="customerReference" class="form-control" maxlength="255" value="{{paymentForm.customerReference}}">
                    {{#field-has-error}}[customerReference]<span class="help-block text-danger">{{#i18n}}{{#field-error}}customerReference{{/field-error}}{{/i18n}}</span>{{/field-has-error}}
                </div>
            </div>
            {{/customerReferenceEnabled}}
        </div>
        {{#invoiceIsAllowed}}
            <div class="row">
                <div class="col-xs-12">
                    {{#onlyInvoice}}
                        <input type="hidden" name="invoiceRequested" id="invoice-requested" value="true">
                        {{#euVatCheckingEnabled}}
                            <div class="checkbox wMarginTop">
                                <label>
                                    <input type="checkbox" name="addCompanyBillingDetails" id="add-company-billing-details" value="true">
                                    {{#i18n}}reservation.add-company-billing-details [{{vatTranslation}}]{{/i18n}}
                                </label>
                            </div>
                        {{/euVatCheckingEnabled}}
                    {{/onlyInvoice}}
                    {{^onlyInvoice}}
                        <div class="checkbox wMarginTop">
                            <label>
                                <input type="checkbox" name="invoiceRequested" id="invoice-requested" value="true" {{#paymentForm.invoiceRequested}}checked{{/paymentForm.invoiceRequested}}>
                                {{#i18n}}reservation-page.i-need-an-invoice{{/i18n}}
                            </label>
                        </div>
                    {{/onlyInvoice}}
                </div>
            </div>
            <div class="row">
                <div id="vat-number-container" class="hidden-xs hidden-sm hidden-md hidden-lg">
                    <div class="col-xs-12">
                        <div class="form-group {{#field-has-error}}[vatNr] has-error{{/field-has-error}}">
                            <label for="vatNr">{{#i18n}}invoice.vat [{{vatTranslation}}]{{/i18n}}</label>
                            <div class="input-group">
                                <div class="input-group-addon" id="selected-country-code"></div>
                                <input id="vatNr" type="text" name="vatNr" class="form-control" value="{{paymentForm.vatNr}}"/>
                            </div>
                            {{#field-has-error}}[vatNr]<span class="help-block text-danger">{{#i18n}}{{#field-error}}vatNr{{/field-error}}{{/i18n}}</span>{{/field-has-error}}
                        </div>
                    </div>
                </div>
            </div>
        {{/invoiceIsAllowed}}

    <div class="page-header">
        <h2>{{#i18n}}reservation-page.attendees{{/i18n}}</h2>
    </div>

    {{#showPostpone}}
        <div class="checkbox">
            <label>
                <input type="checkbox" name="postponeAssignment" id="postpone-assignment" value="true" {{#postponeAssignment}}checked="checked"{{/postponeAssignment}}>
                {{#i18n}}reservation-page.postpone-assignment{{/i18n}}
            </label>
        </div>
    {{/showPostpone}}

    <div id="attendeesData" {{#postponeAssignment}}class="hidden-xs hidden-sm hidden-md hidden-lg"{{/postponeAssignment}}>
        <ul class="list-group">
            {{#ticketsByCategory}}
                {{#value}}
                    <li class="list-group-item">
                        <h3><i class="fa fa-ticket"></i> {{#i18n}}reservation-page-complete.ticket-nr{{/i18n}}<span class="ticket-counter"></span> <span class="hidden-xs hidden-xs">- <small>{{key.name}} - {{key.price}} {{event.currency}}</small></span>{{^attendeeAutocompleteEnabled}}{{#-first}}<button type="button" id="copy-from-contact-data" class="btn btn-xs btn-default tooltip-handler pull-right" title="{{#i18n}}reservation-page.copy-attendee{{/i18n}}"><i class="fa fa-clone"></i><span class="sr-only">{{#i18n}}reservation-page.copy-attendee{{/i18n}}</span></button>{{/-first}}{{/attendeeAutocompleteEnabled}}</h3>
                        <div class="form-horizontal">
                            <div data-collapse-enabled="true" class="collapsible-container">
                                {{> /event/attendee-fields }}
                            </div>
                        </div>
                    </li>
                {{/value}}
            {{/ticketsByCategory}}
        </ul>
    </div>
    <div class="clearfix"></div>
{{/paypalCheckoutConfirmation}}
<div class="row">
    <div class="col-md-4 col-md-push-8 col-xs-12 wMarginBottom"><button type="submit" class="btn btn-success btn-block" id="continue-button">{{#i18n}}reservation-page.continue{{/i18n}}</button></div>
    <div class="col-md-4 col-md-pull-4 col-xs-12"><button type="submit" class="btn btn-default btn-block" id="cancel-reservation">{{#i18n}}reservation-page.cancel{{/i18n}}</button></div>
</div>


 
    <input type="hidden" name="{{_csrf.parameterName}}" value="{{_csrf.token}}">
    
    <div class="clearfix"></div>

</form>

{{>/event/page-bottom}}