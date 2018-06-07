/**
 * This file is part of alf.io.
 *
 * alf.io is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * alf.io is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with alf.io.  If not, see <http://www.gnu.org/licenses/>.
 */
package alfio.controller.form;

import alfio.model.transaction.PaymentProxy;
import lombok.Data;
import org.apache.commons.lang3.StringUtils;

import java.io.Serializable;
import java.util.Optional;

//STEP 3
@Data
public class PaymentOverviewForm implements Serializable {
    private Boolean backFromOverview;
    private String stripeToken;
    private String paypalPaymentId;
    private String paypalPayerID;
    private PaymentProxy paymentMethod;
    private String hmac;
    private Boolean termAndConditionsAccepted;
    private Boolean privacyPolicyAccepted;


    public String getToken() {
        if(paymentMethod == PaymentProxy.STRIPE) {
            return stripeToken;
        } else if(paymentMethod == PaymentProxy.PAYPAL) {
            return paypalPaymentId;
        } else {
            return null;
        }
    }

    public boolean hasPaypalTokens() {
        return StringUtils.isNotBlank(paypalPayerID) && StringUtils.isNotBlank(paypalPaymentId);
    }

    public boolean isBackFromOverview() {
        return Optional.ofNullable(backFromOverview).orElse(false);
    }

    public Boolean shouldCancelReservation() {
        return false;
    }
}
